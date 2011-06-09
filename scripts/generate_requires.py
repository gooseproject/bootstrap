#!/usr/bin/python

import os
import sys
import time
import argparse

# import the rpm parsing stuff
import rpm

def resolve_deps(args):
    srpm = args.rpm

# rpm.ts is an alias for rpm.TransactionSet
    ts = rpm.ts()
    ts.setVSFlags(rpm._RPMVSF_NOSIGNATURES)
    fdno = os.open(srpm, os.O_RDONLY)
    try:
        hdr = ts.hdrFromFdno(fdno)
    except rpm.error, e:
        if str(e) == "public key not available":
            print str(e)
    os.close(fdno)

    print "package"
    print "%s-%s-%s" %( hdr[rpm.RPMTAG_NAME], hdr[rpm.RPMTAG_VERSION], hdr[rpm.RPMTAG_RELEASE])
    print "requires"
    for pkg in hdr[rpm.RPMTAG_REQUIRES]:
        print "- %s" % pkg

def main():

    p = argparse.ArgumentParser(
            description='''Resolves all dependencies for any particular rpm''',
        )

    p.add_argument('rpm', help='rpm to resolve')
    p.set_defaults(func=resolve_deps)


    args = p.parse_args()
#    print "Args: %s" % str(args)

    args.func(args)

if __name__ == "__main__":
    main()
