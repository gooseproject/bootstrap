# settings for create_gh_repo.py / import_srpms.py
import os

login = os.getenv('LOGNAME')
home = os.environ['HOME']

install_root = u"/tmp/projects"

projects_dir = u"Projects"
base_dir = u"%s/%s" % (home, projects_dir)
git_dir = u"%s/%s" % (base_dir, 'gooseproject')
github_org = u"gooseproject"
github_base = u"git@github.com:%s" % github_org
lookaside_dir = u"%s/%s/%s" % (base_dir, 'gooseproject', 'lookaside')
