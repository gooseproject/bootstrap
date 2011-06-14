#!/usr/bin/python

import os
import sys
import time
import shutil
import argparse
import subprocess

# http://packages.python.org/github2/
import gh_settings as ghs
from github2.client import Github


def create_gh_repo(name, org):
    try:
        github = Github(username=ghs.username, api_token=ghs.api_token)
        repo = github.repos.create(u"%s/%s" % (org, name))
        print "Repo: '%s' created" % repo.name
    except RuntimeError, e:
        print str(e.message)

def _create_gh_repo(args):
    name = args.name
    org = args.org

    create_gh_repo(name, org)

def main():
    p = argparse.ArgumentParser(
            description=u"Creates github repository for the appropriate package",
        )

    p.add_argument('name', help='repo name')
    p.add_argument('org', help='user or organization owning repo')
    p.set_defaults(func=_create_gh_repo)

    args = p.parse_args()
    args.func(args)

if __name__ == "__main__":
    sys.exit(main())
