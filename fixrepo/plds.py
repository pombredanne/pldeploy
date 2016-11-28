#!/usr/bin/env python
import os
import subprocess


if __name__ == "__main__":
    proc = subprocess.Popen(["cat", "/etc/issue"], stdout=subprocess.PIPE, shell=False)
    (out, err) = proc.communicate()
    if out is not None and "fedora release 14" in out.lower():
        subprocess.Popen(["cp", "/etc/yum.repos.d/fedora.repo", "/etc/yum.repos.d/fedora.repo.old"],stdout=subprocess.PIPE, shell=False).wait()
        subprocess.Popen(["cp", "/etc/yum.repos.d/fedora-updates.repo", "/etc/yum.repos.d/fedora-updates.repo.old"],stdout=subprocess.PIPE, shell=False).wait()
        subprocess.Popen(["cp", "./fedora.repo", "/etc/yum.repos.d/fedora.repo"],stdout=subprocess.PIPE, shell=False).wait()
        subprocess.Popen(["cp", "./fedora-updates.repo", "/etc/yum.repos.d/fedora-updates.repo"],stdout=subprocess.PIPE, shell=False).wait()
	print "done"
