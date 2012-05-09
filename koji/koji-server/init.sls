/etc/koji-hub/hub.conf:
  file.managed:
    - source: salt://koji-server/files/hub.conf
    - require:
      - pkg: koji-hub

/etc/httpd/conf.d/kojihub.conf:
  file.managed:
    - source: salt://koji-server/files/kojihub.conf
    - require:
      - pkg: koji-hub

/etc/httpd/conf.d/kojiweb.conf:
  file.managed:
    - source: salt://koji-server/files/kojiweb.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: koji-web

/var/lib/pgsql/data/pg_hba.conf:
  file.managed:
    - source: salt://koji-server/files/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 600
    - require:
      - pkg: postgresql-server

postgresql-server:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /var/lib/pgsql/data/pg_hba.conf

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

koji-web:
  pkg:
    - installed
    - require:
      - pkg: httpd

koji-hub:
  pkg:
    - installed
    - require:
      - pkg: httpd

koji-hub-plugins:
  pkg:
    - installed


