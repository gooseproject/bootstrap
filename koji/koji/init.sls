include:
  - koji.hub
  - koji.web
  - koji.ssl

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

create_koji_db:
  file.managed:
    - name: /root/bin/create_koji_db
    - source: salt://koji/files/create_koji_db
    - user: root
    - group: root
    - mode: 775
    - require:
      - user: koji
      - file: /root/bin

/root/bin/create_koji_db:
  cmd:
    - run
    - order: last
    - onlyif: ls /root/bin/create_koji_db
    - require:
      - file: create_koji_db
      - cmd: initdb
