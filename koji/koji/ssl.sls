/etc/pki/koji:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - order: 200

/etc/pki/koji/certs:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /etc/pki/koji

/etc/pki/koji/private:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: /etc/pki/koji

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
    - order: 200
    - require:
      - file: /etc/pki/koji

/etc/pki/koji/index.txt:
  file.touch:
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: /etc/pki/koji

echo 01 > /etc/pki/koji/serial:
  cmd:
    - run
    - unless: ls /etc/pki/koji/serial
    - require:
      - file: /etc/pki/koji

create_koji_pki:
  file.managed:
    - name: /root/bin/create_koji_pki
    - source: salt://koji/files/create_koji_pki
    - user: root
    - group: root
    - mode: 775
    - require:
      - file: /etc/pki/koji/index.txt
      - cmd: echo 01 > /etc/pki/koji/serial

/root/bin/create_koji_pki:
  cmd:
    - run
    - unless: ls /etc/pki/koji/koji_ca_cert.crt
    - require:
      - file: create_koji_pki
      - file: /etc/pki/koji/ssl.cnf

create_ssl_certs:
  file.managed:
    - name: /root/bin/create_ssl_certs
    - source: salt://koji/files/create_ssl_certs
    - user: root
    - group: root
    - mode: 775
    - require:
      - file: create_koji_pki

/etc/httpd/conf.d/ssl.conf:
  file.managed:
    - source: salt://koji/files/ssl.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: mod_ssl

