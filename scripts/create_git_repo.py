#!/usr/bin/python

import os
import sys
import time
import shutil
import argparse
import subprocess

# create git repos and remotes
import git
from git.errors import InvalidGitRepositoryError, NoSuchPathError, GitCommandError


def create_git_repo(path, scm_url):
    try:
        repo = git.Repo(path)
    except InvalidGitRepositoryError, e:
        gitrepo = git.Git(path)
        cmd = ['git', 'init']
        result = git.Git.execute(gitrepo, cmd)
        repo = git.Repo(path)

    try:
        repo.create_remote('origin', scm_url)
    except GitCommandError, e:
        origin = repo.remotes['origin']
        reader = origin.config_reader
        url = reader.get("url")
        if not url == scm_url:
            print u"origin is %s, should be %s. Adjusting" % (url, scm_url)
            try:
                repo.delete_remote('old_origin')
            except GitCommandError, e:
                origin.rename('old_origin')
                repo.create_remote('origin', scm_url)

def _create_git_repo(args):
    name = args.path
    origin = args.origin

    create_git_repo(name, origin)

def main():
    p = argparse.ArgumentParser(
            description=u"Creates local git repository with origin pointing to corresponding github repository",
        )

    p.add_argument('path', help='path to repository')
    p.add_argument('origin', help='path/url to origin')
    p.set_defaults(func=_create_git_repo)

    args = p.parse_args()
    args.func(args)

if __name__ == "__main__":
    sys.exit(main())
