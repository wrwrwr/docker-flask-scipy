bind = '0.0.0.0:8192'
workers = 4
worker_class = 'gevent'
max_requests = 1000000
max_requests_jitter = 1000
limit_request_line = 1024
limit_request_fields = 30
limit_request_field_size = 1024

chdir = '/apps'

loglevel = 'INFO'
accesslog = '-'
errorlog = '-'
