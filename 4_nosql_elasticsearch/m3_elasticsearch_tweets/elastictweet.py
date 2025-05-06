# https://www.pg4e.com/code/elastictweet.py

# Example from:
# https://elasticsearch-py.readthedocs.io/en/master/

# pip install 'elasticsearch<7.14.0'

# (If needed)
# https://www.pg4e.com/code/hidden-dist.py
# copy hidden-dist.py to hidden.py
# edit hidden.py and put in your credentials

from datetime import datetime
from elasticsearch import Elasticsearch
from elasticsearch import RequestsHttpConnection

import hidden
import hashlib
import json

secrets = hidden.elastic()

es = Elasticsearch(
    [secrets['host']],
    http_auth=(secrets['user'], secrets['pass']),
    url_prefix = secrets['prefix'],
    scheme=secrets['scheme'],
    port=secrets['port'],
    connection_class=RequestsHttpConnection,
)
indexname = secrets['user']

# Start fresh
# https://elasticsearch-py.readthedocs.io/en/master/api.html#indices
res = es.indices.delete(index=indexname, ignore=[400, 404])
print("Dropped index")
print(res)

res = es.indices.create(index=indexname)
print("Created the index...")
print(res)



tweets = """
but for now we will focus on the Python equivalent of speak in
humantodog language The nice thing about telling Python to speak is
that we can even tell it what to say by giving it a message in quotes
And we have even written our first syntactically correct Python
sentence Our sentence starts with the function print
"""
tweets = tweets.splitlines()


for i, line in enumerate(tweets):
    doc = {
        'author': 'kimchy',
        'type' : 'tweet',
        'text': line,
        'timestamp': datetime.now(),
    }

    res = es.index(index=indexname, id=i, body=doc)

    print('Added document', i)
    # print(res['result'])


# Note - you can't change the key type after you start indexing documents
res = es.index(index=indexname, id='abc', body=doc)
print('Added document...')
print(res['result'])

res = es.get(index=indexname, id='abc')
print('Retrieved document...')
print(res)

# Read the documents with a search term
# https://www.elastic.co/guide/en/elasticsearch/reference/current/query-filter-context.html
x = {
  "query": {
    "bool": {
      "must": {
        "match": {
          "text": "bonsai"
        }
      },
      "filter": {
        "match": {
          "type": "tweet"
        }
      }
    }
  }
}

res = es.search(index=indexname, body=x)
print('Search results...')
print(res)
print()
print("Got %d Hits:" % len(res['hits']['hits']))
for hit in res['hits']['hits']:
    s = hit['_source']
    print(f"{s['timestamp']} {s['author']}: {s['text']}")


