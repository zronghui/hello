#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests

proxypool_url = 'http://127.0.0.1:5555/random'


def get_random_proxy():
    """
    get random proxy from proxypool
    :return: proxy
    """
    return 'http://' + requests.get(proxypool_url).text.strip()


def main():
    """
    main method, entry point
    :return: none
    """
    print(get_random_proxy())


if __name__ == '__main__':
    main()
