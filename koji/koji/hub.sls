/etc/koji-hub/hub.conf:
  file.managed:
    - source: salt://koji/files/hub.conf
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
        proxy_dns: "/C=US/ST=Utah/L=Murray/O=GoOSe Project/CN=koji.egavas.org/emailAddress=admin@egavas.org"
    - require:
      - pkg: koji-hub

/etc/httpd/conf.d/kojihub.conf:
  file.managed:
    - source: salt://koji/files/kojihub.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: koji-hub

koji-hub:
  pkg:
    - installed
    - require:
      - pkg: httpd

koji-hub-plugins:
  pkg:
    - installed


