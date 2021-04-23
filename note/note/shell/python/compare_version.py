# -*- coding: utf-8 -*-

import urllib2
import json

def read_version(version, json_url):
    try:
        response = urllib2.urlopen(json_url)
        data = json.loads(response.read())
        live_version = data['version']
        if (live_version == version):
            print 'version matched'
        else:
            print 'not matched'
    except Exception, e:
        print e


read_version('1.1.1', 'http://www.vuilendi.com/test_version.json')
