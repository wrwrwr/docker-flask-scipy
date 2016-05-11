bind = '0.0.0.0:80'
workers = 4
worker_class = 'gevent'
max_requests = 1048576
max_requests_jitter = 1024
limit_request_line = 1024
limit_request_fields = 30
limit_request_field_size = 1024

loglevel = 'INFO'
accesslog = '-'
errorlog = '-'
