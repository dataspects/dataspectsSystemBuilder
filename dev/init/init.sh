#/bin/bash

INDEX_TEMPLATE_NAME=general
INDEX_TEMPLATE_BODY=`cat ./dataspectsSystemBuilder/index_templates/master.json`

curl -X PUT "localhost:9200/_template/$INDEX_TEMPLATE_NAME" -H 'Content-Type: application/json' -d "$INDEX_TEMPLATE_BODY"
echo "Template PUT ---"