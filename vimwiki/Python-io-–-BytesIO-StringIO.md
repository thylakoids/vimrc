[Python io – BytesIO, StringIO](https://www.journaldev.com/19178/python-io-bytesio-stringio)
===========================

Python BytesIO
--------------
``` python
import io

stream_str = io.BytesIO(b"JournalDev Python: \x00\x01")
print(stream_str.getvalue())
```

Python StringIO
---------------
``` python
import io

data = io.StringIO()
data.write('JournalDev: ')
print('Python.', file=data)

print(data.getvalue())

data.close()
```

Reading using StringIO
-------------------
``` python
import io

input = io.StringIO('This goes into the read buffer.')
print(input.read())
```

Reading file using StringIO
---------------------
It is also possible to read a file and stream it over a network as Bytes. The
io module can be used to convert a media file like an image to be converted to
bytes. Here is a sample program:
``` python
import io

file = io.open("whale.png", "rb", buffering = 0)
print(file.read())
```

