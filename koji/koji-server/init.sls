include:
  - koji-hub
  - koji-web

koji:
  user:
    - present
    - home: /home/koji
    - fullname: Koji User

/root/bin:
  file.directory:
    - user: root
    - group: root
    - mode: 775

/root/bin/create_koji_db:
  file.managed:
    - source: salt://koji-server/files/create_koji_db
    - user: root
    - group: root
    - mode: 775
    - require:
      - user: koji
      - file: /root/bin
      - file: /var/lib/pgsql/data/pg_hba.conf

/root/bin/create_koji_db:
  cmd:
    - run
    - onlyif: ls /root/bin/create_koji_db &> /dev/null

