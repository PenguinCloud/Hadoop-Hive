#!/bin/bash
ansible-playbook entrypoint.yml  -c local 
echo "Sleeping awaiting action!"
/usr/sbin/sshd -D
/bin/sleep infinity
