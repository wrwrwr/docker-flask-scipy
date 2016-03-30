FROM python:alpine

MAINTAINER wrwrwr <docker@wr.waw.pl>

EXPOSE 8192

# We need the testing repository for OpenBLAS and its dependencies.
ADD apk-repositories.txt /etc/apk/repositories

# NumPy needs (a line of) patching to link against musl.
ADD numpy-musl.patch /tmp/numpy-musl.patch

# Packages needed to build NumPy and SciPy.
RUN apk add --no-cache \
        fortify-headers \
        g++ \
        gcc \
        gfortran \
        libc-dev \
        musl-dev \
        openblas@testing \
        openblas-dev@testing \
# Get a copy of NumPy, patch, and compile it.
    && pip install --upgrade pip \
    && pip download --dest tmp numpy \
    && cd /tmp \
    && tar -zxf numpy-*.tar.gz \
    && patch -p0 < numpy-musl.patch \
    && pip install numpy-*/ \
# Flask, Gunicorn, and SciPy, just enough to run a simple service ;-)
    && pip install \
        flask \
        gevent \
        gunicorn \
        scipy \
# Remove packages that are only needed for building.
    && apk del --no-cache \
        binutils \
        binutils-libs \
        fortify-headers \
        g++ \
        gcc \
        gfortran \
        libc-dev \
        musl-dev \
        openblas-dev@testing \
        pkgconf \
        pkgconfig \
# Clean up (apk and pip caches, NumPy sources, precompiled bytecode).
    && rm -rf \
        /root/.cache/* \
        /tmp/* \
        /var/cache/apk/* \
        `find / -regex '.*\.py[co]'`

# Provide a matching Gunicorn configuration (to be used through --config).
ADD gunicorn-config.py /etc/gunicorn/config.py
