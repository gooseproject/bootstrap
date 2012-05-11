/etc/httpd/conf/httpd.conf:
  file.sed:
    - before: 'MaxRequestsPerChild  4000'
    - after: 'MaxRequestsPerChild  100'

mod_ssl:
  pkg:
    - installed
    - require:
      - pkg: httpd

httpd:
  pkg:
    - installed
  service:
    - running
    - enabled
    - watch:
      - file: /etc/httpd/conf/httpd.conf
      - file: /etc/httpd/conf.d/kojiweb.conf
      - file: /etc/httpd/conf.d/kojihub.conf

setsebool -P httpd_can_network_connect_db 1:
  cmd:
    - run
    - unless: [ "$(getsebool httpd_can_network_connect_db)" == "httpd_can_network_connect_db --> on" ]

