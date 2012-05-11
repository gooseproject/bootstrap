/var/lib/pgsql/data/pg_hba.conf:
  file.managed:
    - source: salt://postgresql-server/files/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 600
    - require:
      - cmd: initdb

postgresql:
  service:
    - running
    - enabled
    - watch:
      - file: /var/lib/pgsql/data/pg_hba.conf

initdb:
  cmd:
    - run
    - name: /etc/init.d/postgresql initdb
    - unless: ls -l /var/lib/pgsql/data/pg_hba.conf
    - require:
      - pkg: postgresql-server

postgresql-server:
  pkg:
    - installed
