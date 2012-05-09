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

/etc/koji-hub/hub.conf:
  file.managed:
    - source: salt://koji-server/files/hub.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        db_name: "koji"
        db_user: "koji"
        db_host: "localhost"
        kojiweb_url: "http://localhost/koji"
        email_domain: "localhost.localdomain"
        proxy_dns: "/C=US/ST=Utah/O=Local Host/OU=kojiweb/CN=localhost/emailAddress=admin@localhost.localdomain"
        kojiweb_secret: "Risebiv4"
    - require:
      - pkg: koji-hub

/etc/httpd/conf.d/kojihub.conf:
  file.managed:
    - source: salt://koji-server/files/kojihub.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: koji-hub

/etc/httpd/conf.d/kojiweb.conf:
  file.managed:
    - source: salt://koji-server/files/kojiweb.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        koji_url: "http://koji.egavas.org/koji/"
        kojihub_url: "http://kojihub.egavas.org/kojihub"
        kojipackages_url: "http://koji.egavas.org/mnt/koji/packages"
        kojimaven_url: "http://koji.egavas.org/mnt/koji/maven2"
        kojiimages_url: "http://koji.egavas.org/mnt/koji/images"
    - defaults:
        db_name: "koji"
    - require:
      - pkg: koji-web

mod_python:
  pkg:
    - installed
 
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


