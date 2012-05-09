.. GoOSe Linux Project documentation master file, created by Clint Savage <herlo1@gmail.com>

GoOSe Linux Project Documentation
=================================

Welcome to the Grand Orthogonal Operating System Experience, or '`GoOSe' Linux <http://www.gooseproject.org/>`_. We're a community who believes a community built enterprise operating system is the best way to build an enterprise operating system. GoOSe Linux is not just another RHEL Clone, we are using open processes and resources to make a binary compatible enterprise Linux.

The community at GoOSe is what comes first. We believe a strong community provides the best opportunity for continued success. While it might be more work up front to get people going, culture and knowledge sharing are what makes GoOSe Linux unique. Following '`The Open Source Way <http://www.theopensourceway.org/wiki/Main_Page>`_', we document as we go to help others grow and learn with us. GoOSe is about community, sharing, technology and passion. Join the next phase in enterprise open source, GoOSe Linux!

Getting Started
---------------

There are several steps to rebuilding an Enterprise Linux. Below are those steps:

1. Bootstrap the Build Environment (code can be found at `<https://github.com/gooseproject/bootstrap>`_).
   * Includes setup instructions for Koji, Mock, git repository, other build tools, QA and more.
2. Build the Packages (code can be found at `<https://github.com/gooseproject/build>`_)
   * Includes recommendations for bootstrapping the chroot, extracting the SRPMS, build ordering, mass building, etc.
3. Release Engineering (code can be found at `<https://github.com/gooseproject/releng>`_)
   * Package signing with sigul, using mash to extract multilib rpms, pungi to compose ISOs, Building LiveCDs and Appliances as well.
4. Quality Assurance (code can be found at `<https://github.com/gooseproject/qa>`_)

This guide covers what it takes to 'Bootstrap the Build Environment'. In other words, all of the preparation it takes to make rebuilding EL possible. Please see the references above for the other components necessary to make a successful Enterprise Linux Rebuild Project.

Bootstrapping the Build Environment
-----------------------------------

Since this is the bootstrap repository, this README focuses on creating the build environment. The point of this repository is to rebuild Enterprise Linux. This document will discuss and design a layout with that in mind. There are several services that need to be bootstrapped before building an operating system can commence. Below is a short list of the things that need to be stood up. Because it's RHEL, we'll use many of the tools provided by the `Fedora Project <http://fedoraproject.org>`_.

Tools
~~~~~

* Koji - The tool used to build the RPMS in a reproducable and reliable way. Koji requires several components to work.

  * koji-hub - The central brain of Koji. Included are a postgresql database and an extensive XML-RPC API.
  * kojid - The koji builder(s). Each builder will perform one of several tasks.

    * Build an package (either from an SRPM or from SCM)
    * Regenerate a repository for a specific tag
    * Create a LiveCD or Appliance

  * kojira - The Koji Repository Administrator. Basically, whenever a build or tag (repo) is updated, kojira sends a regen-repo request to koji-hub.
  * koji-web - The web interface into koji-hub. Shows status of tasks, lists built packages. Can resubmit tasks.

* A Method to extract and store SRPM data

  * Lookaside Cache - Storage location for the archive files (tar.gz, tar.bz2, zip, etc) because storing them in SCM makes it unmanageable and gigantic!
  * SCM - Required to build packages in Koji 'the right way'(tm). The GoOSe Project uses github which makes this trivial. However, managing 2000+ repositories is no small feat. Koji supports a plethora of SCMs which means alternates including mercurial, subversion or others are definitely possible. Alternatives include:

    * Local repository (keep in mind that koji has to be able to have access to the repo)
    * Gitolite with WILDCARD REPOS feature enabled
    * Gitorious may work, though it's not been thoroughly reviewed
    * Bitbucket, LaunchPad, Google Code
    * Many other solutions are available

* Sigul provides a utility for GPG signing RPMS inside koji
* Mash extracts RPMS into usable repositories from koji with multilib support
* Pungi uses the above repositories and builds an installable DVD iso for distribution

Building the Build Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since GoOSe is essentially a RHEL clone, it uses RHEL compatible systems. In our case, we currently use CentOS, but plan to replace the infrastructure with GoOSe systems :).

In this repository exists a directory structure representing each of the tools described above. The configurations in each directory are written specifically for the GoOSe Project systems, but should work for most any environment. Each directory has a README.rst inside which describes how to setup the appropriate tooling. Below is a layout of the directory structure with short descriptions for each directory.

* koji - Salt state for koji-hub, koji-web, kojira and at least one kojid instance
* sigul - Salt state for sigul server, bridge and at least one client configuration. Also includes sigulsign_unsigned.py script for signing GoOSe packages.
* mash - Salt state for mash along with shell script for mashing an repository
* pungi - Salt state for pungi along with a shell script for composing ISOs


