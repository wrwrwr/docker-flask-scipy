FROM continuumio/miniconda3

MAINTAINER wrwrwr <docker@wr.waw.pl>

EXPOSE 8192

RUN conda install --yes \
        flask \
        flask-cors \
        gevent \
        gunicorn \
        requests \
        numpy \
        scipy \
    && conda clean --yes --all

ADD gunicorn-config.py /etc/gunicorn/config.py
