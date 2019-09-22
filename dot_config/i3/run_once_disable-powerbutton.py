#!/usr/bin/python
import os
import sys

# sets HandlePowerKey=ignore in logind.conf

line_cfg = 'HandlePowerKey=ignore'
path_cfg = '/etc/systemd/logind.conf'
path_tmp = '/etc/systemd/logind.conf.new'

# check if this line is already present
with open(path_cfg) as f:
    for line in f:
        line = line.strip()
        if line == line_cfg:
            exit(0)

# get root privileges
if os.geteuid() != 0:
    print('power button not disabled in /etc/systemd/logind.conf')
    # os.execvp() replaces the running process, rather than launching a child
    # process, so there's no need to exit afterwards. The extra "sudo" in the
    # second parameter is required because Python doesn't automatically set $0
    # in the new process.
    os.execvp("sudo", [
        "sudo",
        "python",
        os.path.abspath(__file__)
        ])

# replace line
f_in = open(path_cfg)
f_out = open(path_tmp, 'w')
added = False
for line in f_in:
    line = line.strip()
    if line.startswith(line_cfg) or line.startswith('#' + line_cfg):
        if not added:
            print(line_cfg, file=f_out)
            added = True
        else:
            print('found wanted line twice')
    else:
        print(line, file=f_out)
f_in.close()
f_out.close()

os.rename(path_tmp, path_cfg)

print('updated config, reloading systemd-logind')

os.execvp('systemctl', ['systemctl', 'restart', 'systemd-logind'])
