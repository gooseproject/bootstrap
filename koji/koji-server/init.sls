/etc/koji-hub/hub.conf:
  file.managed:
    - source: salt://koji-server/files/hub.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
        proxy_dns: "/C=US/ST=Utah/O=Local Host/OU=kojiweb/CN=localhost/emailAddress=admin@localhost.localdomain"
    - defaults:
        db_name: "koji"
        db_user: "koji"
        db_host: "localhost"
        kojiweb_url: "http://localhost/koji"
        email_domain: "localhost.localdomain"
        proxy_dns: "/C=US/ST=Utah/O=GoOSe Project/OU=kojiweb/CN=kojiweb.gooselinux.org/emailAddress=admin@gooseproject.org | /C=US/ST=Utah/O=GoOSe Project/CN=kojiadmin/emailAddress=admin@gooseproject.org"
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
    - require:
      - pkg: koji-web

/var/lib/pgsql/data/pg_hba.conf:
  file.managed:
    - source: salt://postgresql-server/files/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 600
    - require:
      - postgres_database: koji

koji:
  postgres_database:
    - present

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


