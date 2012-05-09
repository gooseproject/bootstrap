/var/lib/pgsql/data/pg_hba.conf:
  file.managed:
    - source: salt://postgresql-server/files/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 600
    - require:
      - service: postgresql-server
      - postgres_database: koji

koji:
  postgres_database:
    - present

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

