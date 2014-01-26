#!/usr/bin/env python3.3
# -*- coding: utf-8 -*-
#
# Simple web interface to cve-search to display the last entries
# and view a specific CVE.
#
# Software is free software released under the "Modified BSD license"
#
# Copyright (c) 2013 Alexandre Dulaunoy - a@foo.be

from flask import Flask
from flask import render_template, url_for
from flask.ext.pymongo import PyMongo
import sys
sys.path.append("../lib/")
import cves

app = Flask(__name__, static_folder='static', static_url_path='/static')
app.config['MONGO_DBNAME'] = 'cvedb'
mongo = PyMongo(app)

@app.route('/cve/<cveid>')
def cve(cveid):
    cvesp = cves.last(rankinglookup = True, namelookup = True, vfeedlookup = True)
    cve = cvesp.getcve(cveid=cveid)
    if cve is None:
        return page_not_found(404)
    return render_template('cve.html', cve=cve)

@app.route('/')
def last():
    x = mongo.db.cves.find({}).sort("Modified",-1).limit(50)
    return render_template('index.html', cve=x)

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

if __name__ == '__main__':
        app.run(debug=True)
