#!/usr/local/bin/python3
"""
bamboo.py
BitBar script that polls the status of an Atlassian Bamboo server.
"""

try:
    # pylint: disable=import-error
    from atlassian import Bamboo
except ModuleNotFoundError:
    print('ERROR: Atlassian module not installed.')
    print('Install it with `pip3 install atlassian-python-api`')
    import sys
    sys.exit(2)

URL = 'http://bamboo.datawarehousellc.com:8085'

def main():
    """ Main entrypoint for this script. """
    bamboo = Bamboo(URL)

    output = ['🎍']
    if bamboo:
        activity = bamboo.activity()

        if activity and activity['builds']:
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
    print('\n'.join(output))

if __name__ == '__main__':
    main()
