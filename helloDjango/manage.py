#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys


def main():
    logDir = os.path.join(os.path.dirname(__file__), 'log')
    logFile = os.path.join(logDir, 'debug.log')
    print(logFile)
    if not os.path.exists(logDir):
        os.mkdir(logDir)
    if not os.path.exists(logFile):
        os.system(f'touch {logFile}')

    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'helloDjango.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
