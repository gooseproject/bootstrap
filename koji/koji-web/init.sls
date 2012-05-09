/etc/httpd/conf.d/kojiweb.conf:
  file.managed:
    - source: salt://koji-web/files/kojiweb.conf
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
