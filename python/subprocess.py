#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import subprocess

proc = subprocess.Popen('curl http://192.168.2.180:16800', \
       shell=True, \
       stdout=subprocess.PIPE, \
       stderr=subprocess.PIPE)
proc.wait()

print('stdout: ' + proc.stdout.read())
print('stderr: ' + proc.stderr.read())
print('errno: ' + proc.return_code)
