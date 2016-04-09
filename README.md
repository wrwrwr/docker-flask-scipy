docker-flask-scipy
==================

A small image with fully working [SciPy][] and an infrastructure sufficient for
a simple web service.

Includes:
* [runit][]
* [Gunicorn][] ([gevent][]/[greenlet][])
* [Flask][]
* [NumPy][] and [SciPy][]

[runit]: http://smarden.org/runit/
[Gunicorn]: http://gunicorn.org/
[gevent]: http://www.gevent.org/
[greenlet]: http://greenlet.readthedocs.org/en/latest/
[Flask]: http://flask.pocoo.org/
[NumPy]: http://www.numpy.org/
[SciPy]: http://www.scipy.org/

Usage
-----

Add application code and a `runit` script starting `Gunicorn`.

A basic derived `Dockerfile` could look as follows:

```Dockerfile
FROM wrwrwr/flask-scipy

COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt
COPY . /app
COPY run.sh /etc/service/app/run
```

The `run.sh` script needs to start the `Gunicorn` server:

```bash
#!/usr/bin/env bash

cd /app
gunicorn --config /etc/gunicorn/config.py app:app
```

Possible improvements
---------------------

* Strip the base (Debian) image from `systemd`, docs etc.
* Or research `NumPy` on `Alpine` test errors and reconsider changing the base.
* Compile `ATLAS` during build or allow compiling it for a chosen architecture.
