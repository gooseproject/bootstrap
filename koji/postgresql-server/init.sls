/etc/httpd/conf.d/kojiweb.conf:
  file.managed:
    - source: salt://koji-server/files/kojiweb.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: postgresql-server

service postgresql-server initdb:
  cmd:
    - name: pgsql-initdb
    - run
    - unless: ls -l /var/lib/pgsql/data/

postgresql-server:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /var/lib/pgsql/data/pg_hba.conf
    - require:
      - cmd: pgsql-initdb

