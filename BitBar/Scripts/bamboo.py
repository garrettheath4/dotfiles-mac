#!/usr/bin/env PYTHONIOENCODING=UTF-8 /usr/local/bin/python3
"""
bamboo.py
BitBar script that polls the status of an Atlassian Bamboo server.
"""

import sys
import socket

try:
    # pylint: disable=import-error
    from atlassian import Bamboo
except ModuleNotFoundError:
    print('ERROR: Atlassian module not installed.')
    print('Install it with `pip3 install atlassian-python-api`')
    sys.exit(2)

HOSTNAME = 'bamboo.datawarehousellc.com'
PORT = 8085
URL = f'http://{HOSTNAME}:{PORT}'

def get_output_lines():
    """ Main entrypoint for this script. """

    if not is_domain_resolvable(HOSTNAME):
        return '🌎'

    if not is_port_open(HOSTNAME, PORT):
        return '🛡'

    bamboo = Bamboo(URL)

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
        if builds[0]['percentageComplete']:
            if builds[0]['percentageComplete'] > 25.0:
                build_status = '🕐'
            if builds[0]['percentageComplete'] > 50.0:
                build_status = '🕖'
            if builds[0]['percentageComplete'] > 75.0:
                build_status = '🕙'
    output = [build_status.title() + ' ' + plan_key]
    output += ['---']
    output += [f'Open Bamboo build in browser | href={URL}/browse/{plan_result_key}']
    return output


def is_domain_resolvable(host):
    """
    Usage: is_domain_resolvable(<HOSTNAME_OR_DOMAIN>)
    Returns: bool
    Example: is_domain_resolvable('google.com')
    """
    try:
        socket.gethostbyname(host)
    except:  # pylint: disable=bare-except
        return False
    return True


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
        print('🎍')
