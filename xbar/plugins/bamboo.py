#!/usr/bin/env /usr/bin/python3
# vim: set nobackup:
# <xbar.title>Bamboo Builds</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Garrett Heath Koller</xbar.author>
# <xbar.author.github>garrettheath4</xbar.author.github>
# <xbar.desc>Displays any running builds on a specific Atlassian Bamboo server.</xbar.desc>
# <xbar.var>string(VAR_BAMBOO_HOSTNAME="bamboo"): Hostname of Bamboo server to connect to.</xbar.var>
# <xbar.var>number(VAR_BAMBOO_PORT=8085): Port number of Bamboo server to connect to.</xbar.var>
# <xbar.var>string(VAR_BLOCKED_IPS="92.242.140.21"): Comma-separated list of IP addresses to ignore if given hostname resolves to them.</xbar.var>
"""
bamboo.py
xbar script that polls the status of an Atlassian Bamboo server.
See: https://github.com/matryer/xbar
"""

import os
import sys
import socket

from string import Template

try:
    # pylint: disable=import-error
    from atlassian import Bamboo
except ModuleNotFoundError:
    print('ERROR: Atlassian module not installed.')
    print('Install it with `pip3 install atlassian-python-api`')
    sys.exit(2)

BAMBOO_HOSTNAME = os.environ.get("VAR_BAMBOO_HOSTNAME", "bamboo")
BAMBOO_PORT = os.environ.get("VAR_BAMBOO_PORT", 8085)
if "VAR_BLOCKED_IPS" in os.environ.keys() and os.environ.get("VAR_BLOCKED_IPS"):
    INVALID_IPS = os.environ.get("VAR_BLOCKED_IPS").split(',')
else:
    INVALID_IPS = []

t = Template('http://$hostname:$port')
BAMBOO_URL = t.substitute(hostname=BAMBOO_HOSTNAME, port=BAMBOO_PORT)

def get_output_lines():
    """ Main entrypoint for this script. """

    if not is_domain_resolvable(BAMBOO_HOSTNAME):
        return [':earth_americas:']

    if not is_port_open(BAMBOO_HOSTNAME, BAMBOO_PORT):
        return ['🛡️']

    bamboo = Bamboo(BAMBOO_URL)

    if not bamboo:
        return False

    activity = bamboo.activity()

    if not activity or not activity['builds']:
        return False

    builds = activity['builds']
    plan_key = builds[0]['planKey']
    plan_result_key = builds[0]['planResultKey']
    build_status = builds[0]['status']
    if build_status == 'BUILDING':
        build_status = '🛠'
    if builds[0]['percentageComplete'] and builds[0]['percentageComplete'] in range (1, 100):
        build_status = str(round(builds[0]['percentageComplete'])) + '%'
    output = [plan_key + ' ' + build_status.title()]
    output += ['---']
    output += [f'Open Bamboo build in browser | href={BAMBOO_URL}/browse/{plan_result_key}']
    return output


def is_domain_resolvable(host):
    """
    Usage: is_domain_resolvable(<HOSTNAME_OR_DOMAIN>)
    Returns: bool
    Example: is_domain_resolvable('google.com')
    """
    try:
        ip_addr = socket.gethostbyname(host)
    except:  # pylint: disable=bare-except
        return False
    return ip_addr not in INVALID_IPS


# pylint: disable=invalid-name
def is_port_open(ip, port) -> bool:
    """
    Usage: is_port_open(<IP_ADDRESS>, <PORT_NUM>)
    Returns: bool
    Example: is_port_open('192.168.0.1', 8080)
    """
    sock = socket.socket()
    if not sock:
        return False
    sock.settimeout(5)
    try:
        sock.connect((ip, int(port)))
        sock.shutdown(socket.SHUT_RDWR)
        return True
    except:  # pylint: disable=bare-except
        return False


if __name__ == '__main__':
    output_lines = get_output_lines()
    if output_lines:
        print('\n'.join(output_lines))
    else:
        print(':bamboo:')
