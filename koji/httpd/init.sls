mod_ssl:
  pkg:
    - installed

httpd:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/httpd/conf.d/kojiweb.conf
      - file: /etc/httpd/conf.d/kojihub.conf
