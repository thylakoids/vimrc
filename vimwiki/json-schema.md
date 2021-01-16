[JSON Schema](https://json-schema.org/understanding-json-schema/index.html)
===========

> **JSON Schema** is a vocabulary that allows you to **annotate** and **validate** JSON documents.


Using in Vim(coc-json)
---------------------

### How to Add Custom Schema Definitions/Properties?
You have two choices:

* Use $schema in your json.
* Create json schema file and then configure `json.schemas` in your `coc-settings.json`

    1. Configure `json.schemas` in `coc-settings.json`
        ``` js
        "json.schemas": [
            {
            "fileMatch": ["plot.json"],
            "url": "file:Users/yourname/.vim/schema/plotschema.json"
            }
        ```
    2. (optional)You can use `genson` to generate json schema file
        ``` shell
        pip install genson
        ```

    3. (optional)Config vim key mapping for `genson`.
        ``` vim
        autocmd FileType json nnoremap <Leader>jg :%!genson <cr> :update<cr>
        ```

