/etc/koji-hub/hub.conf:
  file.managed:
    - source: salt://koji-hub/hub.conf
    - require:
     - pkg: koji-hub

/etc/httpd/conf.d/kojihub.conf:
  file.managed:
    - source: salt://koji-hub/kojihub.conf
    - require:
      - pkg: koji-hub

/etc/httpd/conf.d/kojiweb.conf:
  file.managed:
    - source: salt://koji-web/kojiweb.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: koji-web

postgresql-server:
  pkg:
    - installed

mod_python:
  pkg:
    - installed
 
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

koji-hub:
  pkg:
    - installed

koji-hub-plugins:
  pkg:
    - installed

koji-web:
  pkg:
    - installed
    - require:
      - pkg: httpd


