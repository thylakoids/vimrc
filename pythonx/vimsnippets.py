"""Helper methods used in UltiSnips snippets."""

import re
import string

import vim


def complete(tab, opts):
    """
    get options that start with tab
    :param tab: query string
    :param opts: list that needs to be completed
    :return: a string that start with tab
    """
    msg = "({0})"
    if tab:
        opts = [m[len(tab):] for m in opts if m.startswith(tab)]
    if len(opts) == 1:
        return opts[0]

    if not len(opts):
        msg = "{0}"
    return msg.format("|".join(opts))


def _parse_comments(s):
    """ Parses vim's comments option to extract comment format """
    i = iter(s.split(","))

    rv = []
    try:
        while True:
            # get the flags and text of a comment part
            flags, text = next(i).split(':', 1)

            if len(flags) == 0:
                rv.append(('OTHER', text, text, text, ""))
            # parse 3-part comment, but ignore those with O flag
            elif 's' in flags and 'O' not in flags:
                ctriple = ["TRIPLE"]
                indent = ""

                if flags[-1] in string.digits:
                    indent = " " * int(flags[-1])
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'm'
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'e'
                ctriple.append(text)
                ctriple.append(indent)

                rv.append(ctriple)
            elif 'b' in flags:
                if len(text) == 1:
                    rv.insert(0, ("SINGLE_CHAR", text, text, text, ""))
    except StopIteration:
        return rv


def get_comment_format():
    """ Returns a 4-element tuple (first_line, middle_lines, end_line, indent)
    representing the comment format for the current file.
    It first looks at the 'commentstring', if that ends with %s, it uses that.
    Otherwise it parses '&comments' and prefers single character comment
    markers if there are any.
    """
    commentstring = vim.eval("&commentstring")
    if commentstring.endswith("%s"):
        c = commentstring[:-2]
        return (c, c, c, "")
    comments = _parse_comments(vim.eval("&comments"))
    for c in comments:
        if c[0] == "SINGLE_CHAR":
            return c[1:]
    return comments[0][1:]


def get_nerdcomment_format(ft=None):
    """get_nerdcomment_format
    :return:(string before %s, string after %s)
    """
    if ft is None:
        ft = vim.eval('&filetype')

    delimiterMap = {
        'aap': {'left': '#'},
        'abc': {'left': '%'},
        'acedb': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'actionscript': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'ada': {'left': '--', 'leftAlt': '--  '},
        'ahdl': {'left': '--'},
        'ahk': {'left': ';', 'leftAlt': '/*', 'rightAlt': '*/'},
        'amiga': {'left': ';'},
        'aml': {'left': '/*'},
        'ampl': {'left': '#'},
        'ansible': {'left': '#'},
        'apache': {'left': '#'},
        'apachestyle': {'left': '#'},
        'apdl': {'left': '!'},
        'applescript': {'left': '--', 'leftAlt': '(*', 'rightAlt': '*)'},
        'armasm': {'left': ';'},
        'asciidoc': {'left': '//'},
        'asm': {'left': ';', 'leftAlt': '#'},
        'asm68k': {'left': ';'},
        'asn': {'left': '--'},
        'asp': {'left': '%', 'leftAlt': '%*', 'rightAlt': '*%'},
        'asterisk': {'left': ';'},
        'asy': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'atlas': {'left': 'C', 'right': '$'},
        'augeas': {'left': '(*', 'right': '*)'},
        'autohotkey': {'left': ';', 'leftAlt': '/*', 'rightAlt': '*/'},
        'autoit': {'left': ';'},
        'ave': {'left': "'"},
        'awk': {'left': '#'},
        'basic': {'left': "'", 'leftAlt': 'REM '},
        'bbx': {'left': '%'},
        'bc': {'left': '#'},
        'bib': {'left': '//'},
        'bindzone': {'left': ';'},
        'blade': {'left': '{{--', 'right': '--}}'},
        'bst': {'left': '%'},
        'btm': {'left': '::'},
        'c': {'left': '/*', 'right': '*/', 'leftAlt': '//'},
        'cabal': {'left': '--'},
        'calibre': {'left': '//'},
        'caos': {'left': '*'},
        'catalog': {'left': '--', 'right': '--'},
        'cf': {'left': '<!---', 'right': '--->'},
        'cfg': {'left': '#'},
        'cg': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'ch': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'cl': {'left': '#'},
        'clean': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'clipper': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'clojure': {'left': ';'},
        'cmake': {'left': '#'},
        'cocci': {'left': '//'},
        'coffee': {'left': '#', 'leftAlt': '###', 'rightAlt': '###'},
        'conkyrc': {'left': '#'},
        'context': {'left': '%', 'leftAlt': '--'},
        'coq': {'left': '(*', 'right': '*)'},
        'cpp': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'crontab': {'left': '#'},
        'cs': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'csp': {'left': '--'},
        'cterm': {'left': '*'},
        'cucumber': {'left': '#'},
        'cuda': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'cvs': {'left': 'CVS:'},
        'cython': {'left': '# ', 'leftAlt': '#'},
        'd': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'dakota': {'left': '#'},
        'dcl': {'left': '$!'},
        'debcontrol': {'left': '#'},
        'debsources': {'left': '#'},
        'def': {'left': ';'},
        'desktop': {'left': '#'},
        'dhcpd': {'left': '#'},
        'diff': {'left': '#'},
        'django': {'left': '{% comment %}', 'right': '{% endcomment %}', 'leftAlt': '{#', 'rightAlt': '#}'},
        'dns': {'left': ';'},
        'docbk': {'left': '<!--', 'right': '-->'},
        'dockerfile': {'left': '#'},
        'dosbatch': {'left': 'REM ', 'leftAlt': '::'},
        'dosini': {'left': ';'},
        'dot': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'dracula': {'left': ';'},
        'dsl': {'left': ';'},
        'dtml': {'left': '<dtml-comment>', 'right': '</dtml-comment>'},
        'dylan': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'ebuild': {'left': '#'},
        'ecd': {'left': '#'},
        'eclass': {'left': '#'},
        'eiffel': {'left': '--'},
        'elf': {'left': "'"},
        'elixir': {'left': '#'},
        'elm': {'left': '--', 'leftAlt': '{--', 'rightAlt': '--}'},
        'elmfilt': {'left': '#'},
        'ember-script': {'left': '#'},
        'emblem': {'left': '/'},
        'erlang': {'left': '%', 'leftAlt': '%%'},
        'eruby': {'left': '<%#', 'right': '%>', 'leftAlt': '<!--', 'rightAlt': '-->'},
        'esmtprc': {'left': '#'},
        'expect': {'left': '#'},
        'exports': {'left': '#'},
        'factor': {'left': '! ', 'leftAlt': '!# '},
        'fancy': {'left': '#'},
        'faust': {'left': '//'},
        'fgl': {'left': '#'},
        'fluent': {'left': '#', 'leftAlt': '##'},
        'focexec': {'left': '-*'},
        'form': {'left': '*'},
        'fortran': {'left': '!'},
        'foxpro': {'left': '*'},
        'fsharp': {'left': '(*', 'right': '*)', 'leftAlt': '//'},
        'fstab': {'left': '#'},
        'fvwm': {'left': '#'},
        'fx': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'gams': {'left': '*'},
        'gdb': {'left': '#'},
        'gdmo': {'left': '--'},
        'gdscript3': {'left': '# ', 'leftAlt': '#'},
        'geek': {'left': 'GEEK_COMMENT:'},
        'genshi': {'left': '<!--', 'right': '-->', 'leftAlt': '{#', 'rightAlt': '#}'},
        'gentoo-conf-d': {'left': '#'},
        'gentoo-env-d': {'left': '#'},
        'gentoo-init-d': {'left': '#'},
        'gentoo-make-conf': {'left': '#'},
        'gentoo-package-keywords': {'left': '#'},
        'gentoo-package-mask': {'left': '#'},
        'gentoo-package-use': {'left': '#'},
        'gitcommit': {'left': '#'},
        'gitconfig': {'left': ';'},
        'gitignore': {'left': '#'},
        'gitrebase': {'left': '#'},
        'glsl': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'gnuplot': {'left': '#'},
        'go': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'groff': {'left': '\#'},
        'groovy': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'gsp': {'left': '<%--', 'right': '--%>', 'leftAlt': '<!--', 'rightAlt': '-->'},
        'gtkrc': {'left': '#'},
        'h': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'haml': {'left': '-#', 'leftAlt': '/'},
        'handlebars': {'left': '{{!-- ', 'right': ' --}}'},
        'haskell': {'left': '--', 'nested': 0, 'leftAlt': '{-', 'rightAlt': '-}', 'nestedAlt': 1},
        'haxe': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'hb': {'left': '#'},
        'hbs': {'left': '{{!-- ', 'right': ' --}}'},
        'hercules': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'hive': {'left': '-- '},
        'hog': {'left': '#'},
        'hostsaccess': {'left': '#'},
        'htmlcheetah': {'left': '##'},
        'htmldjango': {'left': '{% comment %}', 'right': '{% endcomment %}', 'leftAlt': '{#', 'rightAlt': '#}'},
        'htmlos': {'left': '#', 'right': '/#'},
        'hxml': {'left': '#'},
        'hyphy': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'ia64': {'left': '#'},
        'icon': {'left': '#'},
        'idl': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'idlang': {'left': ';'},
        'idris': {'leftAlt': '--', 'left': '{-', 'right': '-}'},
        'incar': {'left': '!'},
        'inform': {'left': '!'},
        'inittab': {'left': '#'},
        'ishd': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'iss': {'left': ';'},
        'ist': {'left': '%'},
        'jade': {'left': '//-', 'leftAlt': '//'},
        'java': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'javacc': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'javascript': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'javascriptreact': {'left': '//', 'leftAlt': '{/*', 'rightAlt': '*/}'},
        'javascript.jquery': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'jess': {'left': ';'},
        'jgraph': {'left': '(*', 'right': '*)'},
        'jinja': {'left': '{#', 'right': '#}', 'leftAlt': '<!--', 'rightAlt': '-->'},
        'jproperties': {'left': '#'},
        'jsp': {'left': '<%--', 'right': '--%>'},
        'julia': {'left': '# ', 'leftAlt': '#=', 'rightAlt': '=#'},
        'kivy': {'left': '#'},
        'kix': {'left': ';'},
        'kscript': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'lace': {'left': '--'},
        'laravel': {'left': '{{--', 'right': '--}}'},
        'ldif': {'left': '#'},
        'ledger': {'left': '#', 'leftAlt': ';'},
        'less': {'left': '/*', 'right': '*/'},
        'lhaskell': {'left': '>{-', 'right': '-}', 'leftAlt': '>-- '},
        'lilo': {'left': '#'},
        'lilypond': {'left': '%'},
        'liquid': {'left': '{% comment %}', 'right': '{% endcomment %}'},
        'lisp': {'left': ';', 'nested': 1, 'leftAlt': '#|', 'rightAlt': '|#', 'nestedAlt': 1},
        'llvm': {'left': ';'},
        'lotos': {'left': '(*', 'right': '*)'},
        'lout': {'left': '#'},
        'lpc': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'lprolog': {'left': '%'},
        'lscript': {'left': "'"},
        'lss': {'left': '#'},
        'lua': {'left': '--', 'leftAlt': '--[[', 'rightAlt': ']]'},
        'lynx': {'left': '#'},
        'lytex': {'left': '%'},
        'm4': {'left': 'dnl '},
        'mail': {'left': '> '},
        'mako': {'left': '##'},
        'man': {'left': '."'},
        'mandoc': {'left': '.\\"'},
        'map': {'left': '%'},
        'maple': {'left': '#'},
        'markdown': {'left': '<!--', 'right': '-->'},
        'masm': {'left': ';'},
        'mason': {'left': '<% #', 'right': '%>'},
        'master': {'left': '$'},
        'matlab': {'left': '%', 'leftAlt': '%{', 'rightAlt': '%}'},
        'mel': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'meson': {'left': '#'},
        'mib': {'left': '--'},
        'minizinc': {'left': '% ', 'leftAlt': '/*', 'rightAlt': '*/'},
        'mips': {'left': '#'},
        'mirah': {'left': '#'},
        'mkd': {'left': '<!---', 'right': '-->'},
        'mma': {'left': '(*', 'right': '*)'},
        'model': {'left': '$', 'right': '$'},
        'modula2': {'left': '(*', 'right': '*)'},
        'modula3': {'left': '(*', 'right': '*)'},
        'molpro': {'left': '!'},
        'monk': {'left': ';'},
        'mush': {'left': '#'},
        'mustache': {'left': '{{!', 'right': '}}'},
        'nagios': {'left': ';'},
        'named': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'nasm': {'left': ';'},
        'nastran': {'left': '$'},
        'natural': {'left': '/*'},
        'ncf': {'left': ';'},
        'newlisp': {'left': ';'},
        'nginx': {'left': '#'},
        'nimrod': {'left': '#'},
        'nroff': {'left': '\"'},
        'nsis': {'left': '#'},
        'ntp': {'left': '#'},
        'objc': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'objcpp': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'objj': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'ocaml': {'left': '(*', 'right': '*)', 'nested': 1},
        'occam': {'left': '--'},
        'octave': {'left': '%', 'leftAlt': '#'},
        'omlet': {'left': '(*', 'right': '*)'},
        'omnimark': {'left': ';'},
        'ooc': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'openroad': {'left': '//'},
        'opl': {'left': 'REM'},
        'ora': {'left': '#'},
        'ox': {'left': '//'},
        'paludis-use-conf': {'left': '#'},
        'pandoc': {'left': '<!--', 'right': '-->'},
        'pascal': {'left': '{', 'right': '}', 'leftAlt': '(*', 'rightAlt': '*)'},
        'patran': {'left': '$', 'leftAlt': '/*', 'rightAlt': '*/'},
        'pcap': {'left': '#'},
        'pccts': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'pdf': {'left': '%'},
        'perl': {'left': '#'},
        'pfmain': {'left': '//'},
        'php': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'pic': {'left': ';'},
        'pike': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'pilrc': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'pine': {'left': '#'},
        'plm': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'plsql': {'left': '-- ', 'leftAlt': '/*', 'rightAlt': '*/'},
        'po': {'left': '#'},
        'poscar': {'left': '!'},
        'postscr': {'left': '%'},
        'pov': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'povini': {'left': ';'},
        'ppd': {'left': '%'},
        'ppwiz': {'left': ';;'},
        'praat': {'left': '#'},
        'privoxy': {'left': '#'},
        'processing': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'prolog': {'left': '%', 'leftAlt': '/*', 'rightAlt': '*/'},
        'proto': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'ps1': {'left': '#'},
        'psf': {'left': '#'},
        'ptcap': {'left': '#'},
        'pug': {'left': '//-', 'leftAlt': '//'},
        'puppet': {'left': '#'},
        'pyrex': {'left': '# ', 'leftAlt': '#'},
        'python': {'left': '# ', 'leftAlt': '#'},
        'r': {'left': '#', 'leftAlt': '#'''},
        'racket': {'left': ';', 'nested': 1, 'leftAlt': '#|', 'rightAlt': '|#', 'nestedAlt': 1},
        'radiance': {'left': '#'},
        'ratpoison': {'left': '#'},
        'rc': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'rebol': {'left': ';'},
        'registry': {'left': ';'},
        'remind': {'left': '#'},
        'renpy': {'left': '# '},
        'resolv': {'left': '#'},
        'rgb': {'left': '!'},
        'rib': {'left': '#'},
        'rmd': {'left': '<!--', 'right': '-->', 'leftalt': '#'},
        'robot': {'left': '#'},
        'robots': {'left': '#'},
        'rspec': {'left': '#'},
        'ruby': {'left': '#'},
        'rust': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'sa': {'left': '--'},
        'samba': {'left': ';', 'leftAlt': '#'},
        'sass': {'left': '//', 'leftAlt': '/*'},
        'sather': {'left': '--'},
        'scala': {'left': '//', 'nested': 1, 'leftAlt': '/*', 'rightAlt': '*/', 'nestedAlt': 1},
        'scheme': {'left': ';', 'nested': 1, 'leftAlt': '#|', 'rightAlt': '|#', 'nestedAlt': 1},
        'scilab': {'left': '//'},
        'scilla': {'left': '(*', 'right': '*)', 'nested': 1},
        'scons': {'left': '#'},
        'scsh': {'left': ';'},
        'scss': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'sdc': {'left': '#'},
        'sed': {'left': '#'},
        'sentinel': {'left': '#', 'leftAlt': '/*', 'rightAlt': '*/'},
        'sgmldecl': {'left': '--', 'right': '--'},
        'sgmllnx': {'left': '<!--', 'right': '-->'},
        'sh': {'left': '#'},
        'shader_test': {'left': '#'},
        'sicad': {'left': '*'},
        'sile': {'left': '%'},
        'simula': {'left': '%', 'leftAlt': '--'},
        'sinda': {'left': '$'},
        'skill': {'left': ';'},
        'slang': {'left': '%'},
        'slice': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'slim': {'left': '/', 'leftAlt': '/!'},
        'slrnrc': {'left': '%'},
        'sls': {'left': '#'},
        'sm': {'left': '#'},
        'smarty': {'left': '{*', 'right': '*}'},
        'smil': {'left': '<!', 'right': '>'},
        'smith': {'left': ';'},
        'sml': {'left': '(*', 'right': '*)', 'nested': 1},
        'snakemake': {'left': '#'},
        'snippets': {'left': '#'},
        'snnsnet': {'left': '#'},
        'snnspat': {'left': '#'},
        'snnsres': {'left': '#'},
        'snobol4': {'left': '*'},
        'spec': {'left': '#'},
        'specman': {'left': '//'},
        'spectre': {'left': '//', 'leftAlt': '*'},
        'spice': {'left': '$'},
        'sql': {'left': '-- ', 'leftAlt': '/*', 'rightAlt': '*/'},
        'sqlforms': {'left': '-- '},
        'sqlj': {'left': '-- '},
        'sqr': {'left': '!'},
        'squid': {'left': '#'},
        'ss': {'left': ';', 'leftAlt': '#|', 'rightAlt': '|#'},
        'sshconfig': {'left': '#'},
        'sshdconfig': {'left': '#'},
        'st': {'left': '"'},
        'stan': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'stp': {'left': '/*', 'right': '*/', 'leftAlt': '//'},
        'supercollider': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'swift': {'left': '/*', 'right': '*/', 'leftAlt': '//'},
        'systemverilog': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'tads': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'tags': {'left': ';'},
        'tak': {'left': '$'},
        'tasm': {'left': ';'},
        'tcl': {'left': '#'},
        'teak': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'terraform': {'left': '#', 'leftAlt': '/*', 'rightAlt': '*/'},
        'tex': {'left': '%'},
        'texinfo': {'left': '@c '},
        'texmf': {'left': '%'},
        'tf': {'left': '#'},
        'tidy': {'left': '#'},
        'tli': {'left': '#'},
        'tmux': {'left': '#'},
        'toml': {'left': '#'},
        'trasys': {'left': '$'},
        'troff': {'left': '.\\"'},
        'tsalt': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'tsscl': {'left': '#'},
        'tssgm': {'left': "comment = '", 'right': "'"},
        'ttl': {'left': '#'},
        'tup': {'left': '#'},
        'twig': {'left': '{#', 'right': '#}'},
        'txt2tags': {'left': '%'},
        'typescript': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'typescriptreact': {'left': '//', 'leftAlt': '{/*', 'rightAlt': '*/}'},
        'uc': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'uil': {'left': '!'},
        'upstart': {'left': '#'},
        'vala': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'vasp': {'left': '!'},
        'vb': {'left': "'"},
        'velocity': {'left': '##', 'right': '', 'leftAlt': '#*', 'rightAlt': '*#'},
        'vera': {'left': '/*', 'right': '*/', 'leftAlt': '//'},
        'verilog': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'verilog_systemverilog': {'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'},
        'vgrindefs': {'left': '#'},
        'vhdl': {'left': '--'},
        'vimperator': {'left': '"'},
        'virata': {'left': '%'},
        'vrml': {'left': '#'},
        'vsejcl': {'left': '/*'},
        'webmacro': {'left': '##'},
        'wget': {'left': '#'},
        'wikipedia': {'left': '<!--', 'right': '-->'},
        'winbatch': {'left': ';'},
        'wml': {'left': '#'},
        'wvdial': {'left': ';'},
        'xdefaults': {'left': '!'},
        'xkb': {'left': '//'},
        'xmath': {'left': '#'},
        'xpm2': {'left': '!'},
        'xquery': {'left': '(:', 'right': ':)'},
        'yaml': {'left': '#'},
        'z8a': {'left': ';'}
    }
    if ft in delimiterMap:
        com = delimiterMap[ft]
        if 'left' in com and 'right' in com:
            return (com['left'], com['right'])
        elif 'leftAlt' in com and 'rightAlt' in com:
            return (com['leftAlt'], com['rightAlt'])
        elif 'left' in com:
            return (com['left'], '')
    else:
        return ('', '')


def make_box(twidth, bwidth=None):
    b, m, e, i = (s.strip() for s in get_comment_format())
    bwidth_inner = bwidth - 3 - max(len(b), len(i + e)) if bwidth else twidth + 2
    sline = b + m + bwidth_inner * m[0] + 2 * m[0]
    nspaces = (bwidth_inner - twidth) // 2
    mlines = i + m + " " + " " * nspaces
    mlinee = " " + " " * (bwidth_inner - twidth - nspaces) + m
    eline = i + m + bwidth_inner * m[0] + 2 * m[0] + e
    return sline, mlines, mlinee, eline


def foldmarker():
    "Return a tuple of (open fold marker, close fold marker)"
    return vim.eval("&foldmarker").split(",")


def noexitdocstring(snip) -> bool:
    """Return if python function already exit docstring.
    todo:notworking match '''
    """
    return (len(snip.buffer) == snip.line + 1) or not re.match('\s*"""', snip.buffer[snip.line + 1])
