require 'dataspects'

elasticsearchCluster = Dataspects::ElasticsearchCluster.new(url: "http://localhost:9200")
index = "dataspectspublic"

################################################################################
queryString = "search"
query = Dataspects::ElasticsearchQuery.new( elasticsearchCluster: elasticsearchCluster, index: index,
  query: { match: { HasEntityName: queryString } })
puts query.topHits(1).containsDirectField( directField: "HasEntityName", value: "C1296112675" )
################################################################################

################################################################################
queryString = "mongo"
query = Dataspects::ElasticsearchQuery.new( elasticsearchCluster: elasticsearchCluster, index: index,
  query: { query_string: { default_field: "HasEntityName", query: queryString } } )
puts query.topHits(10).containsDirectField( directField: "HasEntityName", value: "C0792223532" )
################################################################################
