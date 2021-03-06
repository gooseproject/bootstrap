include:
  - koji.hub
  - koji.web
  - koji.ssl

koji:
  user:
    - present
    - home: /home/koji
    - fullname: Koji User

kojiadmin:
  user:
    - present
    - home: /home/kojiadmin
    - fullname: Koji Admin

/home/kojiadmin/.koji/config:
  file.managed:
    - source: salt://koji/files/config
    - user: kojiadmin
    - group: kojiadmin
    - mode: 644
    - makedirs: true
    - template: jinja
    - context:
        kojiweb_url: "http://koji2.egavas.org/koji/"
        kojihub_url: "http://kojihub2.egavas.org/kojihub"
        kojipkg_url: "http://kojihub2.egavas.org/mnt/koji/packages"
    - require:
      - user: kojiadmin
#      - file: /home/kojiadmin/.koji/client.crt
#      - file: /home/kojiadmin/.koji/clientca.crt
#      - file: /home/kojiadmin/.koji/serverca.crt

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
    - unless: ls /var/lib/pgsql/data/koji_db_exists
    - require:
      - file: create_koji_db
      - cmd: initdb

{% for dir in 'packages','repos','work','scratch' %}
/mnt/koji/{{ dir }}:
  file.directory:
    - user: apache
    - group: apache
    - mode: 755
    - makedirs: True
{% endfor %}
    - require:
      - pkg: httpd

