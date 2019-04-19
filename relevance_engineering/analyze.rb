require 'dataspects'
# [[UsesElasticsearchAPI::_analyze]]
class Dataspects::ElasticsearchCluster
  def analyze(index:, body:)
    # https://www.rubydoc.info/gems/elasticsearch-api/Elasticsearch/API/Indices/Actions#analyze-instance_method
    @client.indices.analyze(
      index: index,
      body: body
    )
  end
  def report(aspects:)
    file = File.open("analyze.html", 'w') do |f|
      f << "<h1>dataspects Elasticsearch Analysis Overview _analyze</h1>"
      f << "<style>.aspect { float:left; background-color:beige; margin:20px; padding:20px; } </style>"
      aspects.each do |aspect|
        f << <<-HEREDOC
            <div class="aspect">
              <h2>Profile</h2><pre>#{JSON.pretty_generate(aspect)}</pre>
              <h2>Analysis</h2><pre>#{JSON.pretty_generate(analyze(aspect))}</pre>
            </div>
          HEREDOC
      end
    end
  end
end

esc = Dataspects::ElasticsearchCluster.new(url: "http://localhost:9200")
text = "search relevance tuning"
index = "dataspectspublic"
aspects = [
  { index: index, body: { text: text, analyzer: "standard" } },
  { index: index, body: { text: text, analyzer: "simple" } },
  { index: index, body: { text: text, analyzer: "whitespace" } },
  { index: index, body: { text: text, analyzer: "stop" } },
  { index: index, body: { text: text, analyzer: "keyword" } },
  { index: index, body: { text: text, tokenizer: "standard" } },
  { index: index, body: { text: text, tokenizer: "letter" } },
  { index: index, body: { text: text, tokenizer: "lowercase" } },
  { index: index, body: { text: text, tokenizer: "whitespace" } },
  { index: index, body: { text: text, tokenizer: "lowercase" } },
  { index: index, body: { text: text, tokenizer: "ngram" } }, # How to make configurable?
  { index: index, body: { text: text, field: "HasEntityName" } },
  { index: index, body: { text: text, field: "HasEntityURL" } },
  { index: index, body: { text: text, field: "HasEntityTitle" } },
  { index: index, body: { text: text, field: "HasEntityTitleTypeKeywordsBlurb" } },
  { index: index, body: { text: text, field: "HasEntityTypeAndEntityTitle" } },
  { index: index, body: { text: text, field: "HasEntityKeywords" } },
  { index: index, body: { text: text, field: "completion" } },
  { index: index, body: { text: text, field: "HasEntityBlurbTEXT" } },
  { index: index, body: { text: text, field: "HasEntityContentTEXT" } },
  { index: index, body: { text: text, field: "HasEntityAnnotations.predicate" } },
  { index: index, body: { text: text, field: "HasEntityAnnotations.object" } }
]
esc.report( aspects: aspects )
