/etc/pki/koji:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/pki/koji/certs:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/pki/koji/private:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/pki/koji/ssl.cnf:
  file.managed:
    - source: salt://koji/files/ssl.cnf
    - template: jinja
    - context:
        ssl_ca_country: "US"
        ssl_ca_province: "Utah"
        ssl_locality: "Murray"
        ssl_ca_organization: "GoOSe Project"
    - user: root
    - group: root
    - mode: 644

/etc/pki/koji/index.txt:
  file.touch:
    - user: root
    - group: root
    - mode: 644

echo 01 > /etc/pki/koji/serial:
  cmd:
    - run
    - unless: ls /etc/pki/koji/serial
