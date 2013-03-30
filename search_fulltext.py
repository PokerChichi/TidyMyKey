#!/usr/bin/env python3.1
# -*- coding: utf-8 -*-
#
# Search the CVE fulltext database
#
# Software is free software released under the "Modified BSD license"
#
# Copyright (c) 2012-2013 Alexandre Dulaunoy - a@foo.be

import pymongo
import os
import argparse
import sys

connect = pymongo.Connection()
db = connect.cvedb
collection = db.cves

indexpath = "./indexdir"

sys.path.append("./lib/")
import cves

from whoosh import index
from whoosh.fields import *
schema = Schema(title=TEXT(stored=True), path=ID(stored=True), content=TEXT)

ix = index.open_dir("indexdir")

from whoosh.qparser import QueryParser

def getcve (cveid=None):
    if cveid is None:
        return False
    return collection.find_one({'id': cveid})

argParser = argparse.ArgumentParser(description='Fulltext search for cve-search')
argParser.add_argument('-q', action='append', help='query to lookup (one or more)')
argParser.add_argument('-t', action='store_true', help='output title of the match CVE(s)')
argParser.add_argument('-j', action='store_true', help='output JSON for match CVE(s)')
argParser.add_argument('-f', action='store_true', help='output matching CVE(s) in JSON')
argParser.add_argument('-m', type=int, default=30, help='most frequent terms (default is 30)')
argParser.add_argument('-l', action='store_true', help='dump all terms encountered in CVE description')
argParser.add_argument('-g', action='store_true', help='graph of most frequent terms with each matching CVE')
args = argParser.parse_args()

from whoosh.query import *
if args.q:
    with ix.searcher() as searcher:
        query = QueryParser("content", ix.schema).parse(" ".join(args.q))
        results = searcher.search(query, limit=None)
        if args.f:
            cves = cves.last()
        for x in results:
            if not args.j:
                if not args.f:
                    print (x['path'])
                elif args.f:
                    print (cves.getcve(x['path']))

                if args.t:
                    print (" -- "+x['title'])
            else:
                print (getcve (cveid=x['path']))
elif args.m and not args.l and not args.g:
    xr = ix.searcher().reader()
    for x in xr.most_frequent_terms("content", number=args.m):
        print (str(int(x[0]))+","+x[1])
elif args.l and not args.g:
    xr = ix.searcher().reader()
    for x in xr.lexicon("content"):
        print (x)
elif args.g:
    import json
    xr = ix.searcher().reader()
    s = {"name": 'cve-search', "children": []}
    for x in xr.most_frequent_terms("content", 2000):
        query = QueryParser("content", ix.schema).parse(x[1])
        r = ix.searcher().search(query,limit=1000)
        c = []
        d = {}
        # list of CVE per keyword
        #for v in r: c.append(v['path']+" ")
        d["size"] = str(int(x[0]))
        d["name"] = x[1]
        s['children'].append(d)
    print (json.dumps(s))
else:
    argParser.print_help()
    exit(1)
