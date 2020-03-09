#/bin/bash

INDEX_TEMPLATE_NAME=general
INDEX_TEMPLATE_BODY=`cat indexTemplates/general.json`

curl -X PUT "localhost:9200/_template/$INDEX_TEMPLATE_NAME" -H 'Content-Type: application/json' -d "$INDEX_TEMPLATE_BODY"
echo "Template PUT ---"