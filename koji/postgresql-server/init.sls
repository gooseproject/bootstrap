/var/lib/pgsql/data/pg_hba.conf:
  file.managed:
    - source: salt://postgresql-server/files/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 600
    - require:
      - cmd: /etc/init.d/postgresql initdb

postgresql:
  service:
    - running
    - watch:
      - file: /var/lib/pgsql/data/pg_hba.conf
    - require:
      - cmd: /etc/init.d/postgresql initdb

/etc/init.d/postgresql initdb:
  cmd:
    - run
    - unless: ls -l /var/lib/pgsql/data/pg_hba.conf
    - require:
      - pkg: postgresql-server

postgresql-server:
  pkg:
    - installed
