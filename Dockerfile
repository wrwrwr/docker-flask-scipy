FROM python:slim

MAINTAINER wrwrwr <docker@wr.waw.pl>

# The provided Gunicorn configuration specifies this port.
EXPOSE 8192

# Install an up-to-date Flask and SciPy from PyPI.
RUN apt-get update && apt-get install --yes \
        g++ \
        gcc \
        gfortran \
        libatlas3-base \
        libatlas-dev \
        liblapack3 \
        liblapack-dev \
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

# Provide a matching Gunicorn configuration (to be used through --config).
ADD gunicorn-config.py /etc/gunicorn/config.py
