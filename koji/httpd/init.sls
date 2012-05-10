/etc/httpd/conf/httpd.conf:
  file.sed:
    - before: 'MaxRequestsPerChild  4000'
    - after: 'MaxRequestsPerChild  100'

mod_ssl:
  pkg:
    - installed

httpd:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/httpd/conf/httpd.conf:
      - file: /etc/httpd/conf.d/kojiweb.conf
      - file: /etc/httpd/conf.d/kojihub.conf
