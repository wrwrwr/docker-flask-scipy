FROM python:slim

MAINTAINER wrwrwr <docker@wr.waw.pl>

# Install runit, and up-to-date Flask and SciPy from PyPI.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --yes \
        g++ \
        gcc \
        gfortran \
        libatlas3-base \
        libatlas-dev \
        liblapack3 \
        liblapack-dev \
        runit \
    && pip install --upgrade pip \
    && pip install \
        flask \
        gevent \
        gunicorn \
        scipy \
    && apt-get purge --yes --auto-remove \
        g++ \
        gcc \
        gfortran \
        libatlas-dev \
        liblapack-dev \
    && rm -rf \
        /var/lib/apt/lists/*

# An example Gunicorn configuration (to be used through --config).
COPY gunicorn-config.py /etc/gunicorn/config.py

# The provided Gunicorn configuration specifies this port.
EXPOSE 8192

# Add application start scripts to /etc/service/<app>/:
#
#    COPY run.sh /etc/service/app/run
#
# The script would contain something like:
#
#    #!/usr/bin/env bash
#
#    cd /app
#    gunicorn --config /etc/gunicorn/config.py app:app

COPY ./runit.sh /runit.sh
ENTRYPOINT ["/runit.sh"]
