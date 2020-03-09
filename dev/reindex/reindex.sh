#/bin/bash

INDEX_TEMPLATE_NAME=masterdev
INDEX_TEMPLATE_BODY=`cat ./dataspectsSystemBuilder/index_templates/masterdev.json`

SOURCE_INDEX=mediawiki_11
TARGET_INDEX=mediawikidev

curl -X PUT "localhost:9200/_template/$INDEX_TEMPLATE_NAME" -H 'Content-Type: application/json' -d "$INDEX_TEMPLATE_BODY"
echo "Template PUT ---"

curl -X DELETE "localhost:9200/$TARGET_INDEX"
echo "Index $TARGET_INDEX DELETED ---"

curl -X PUT "localhost:9200/$TARGET_INDEX"
echo "Index $TARGET_INDEX PUT ---"

curl -X POST "localhost:9200/_reindex" -H 'Content-Type: application/json' -d'
{
    "source": {
    "index": "'$SOURCE_INDEX'"
    },
    "dest": {
    "index": "'$TARGET_INDEX'"
    }
}'
echo "Reindexed ---"

curl -X POST "localhost:9200/_aliases" -H 'Content-Type: application/json' -d '
{
    "actions" : [
        { "add" :
            {
                "indices" :[ "'$TARGET_INDEX'" ],
                "aliases" : [ "anonymous", "authenticated" ]
            }
        }
    ]
}'
echo "Aliased ---"

# Analyzer
# curl -X GET "localhost:9200/shingles_mediawiki/_analyze?pretty" -H 'Content-Type: application/json' -d'
# {
#   "field": "shingled_all",
#   "text": "The quick Brown Fox"
# }'

# sleep 5

# curl -X GET "localhost:9200/shingles_mediawiki/_search?pretty" -H 'Content-Type: application/json' -d'
# {
#   "size": 0,
#   "query": {
#     "bool": 
#       {
#         "must": [
#           {
#             "term": {
#               "HasEntityTitle": "dataspects"
#             }
#           }
#         ]
#       }
#   },
#   "aggs": {
#     "titleTerms": {
#       "terms": {
#         "size": 10,
#         "field": "HasEntityTitle"
#       },
#       "aggs": {
#         "topTitles": {
#           "top_hits": {
#             "_source": {
#               "includes": [
#                 "HasEntityTitle"
#               ]
#             },
#             "size": 10
#           }
#         }
#       }
#     }
#   }
# }'












