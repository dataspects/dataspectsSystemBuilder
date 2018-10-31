@jsonEntitiesIndexMappings = {
  _doc: {
    _source: {
      enabled: true
    },
    properties: {
      # Resource silo level
      OriginatedFromResourceSiloID: {
        type: 'keyword',
        index: false,
        store: false
      },
      OriginatedFromResourceSiloLabel: {
        type: 'keyword',
        index: true,
        store: false
      },
      OriginatedFromResourceSiloType: {
        type: 'keyword',
        index: true,
        store: false
      },
      # Resource level
      HasResourceName: {
        type: 'keyword',
        index: true,
        store: false
      },
      HasResourceURL: {
        type: 'keyword',
        index: true,
        store: false
      },
      HasResourceType: {
        type: 'keyword',
        index: true,
        store: false
      },
      # Entity/subject level
      HasEntityClass: { # Value is 'dskmf-subject'
        type: 'keyword', # https://smw-cindykate.com/main/Component1212749423
        index: false, # https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-index.html
        store: false # https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-store.html
      },
      HasEntityType: {
        type: 'keyword',
        store: true,
        index: true,
        fields: {
          text: {
            type: 'text',
            analyzer: 'my_ngram_tokenizer_analyzer',
            index: true,
            store: false
          }
        }
      },
      HasEntityName: {
        type: 'text',
        store: false
      },
      HasEntityURL: {
        type: 'text',
        store: false
      },
      HasEntityTitleTypeKeywordsBlurb: {
        type: 'text',
        store: false
      },
      HasEntityTitle: {
        type: 'text',
        analyzer: 'my_ngram_tokenizer_analyzer', # https://www.elastic.co/guide/en/elasticsearch/reference/6.2/analysis-ngram-tokenizer.html
        term_vector: 'with_positions_offsets_payloads',
        store: false
      },
      HasEntityTypeAndEntityTitle: {
        type: 'text',
        analyzer: 'my_ngram_tokenizer_analyzer', # https://www.elastic.co/guide/en/elasticsearch/reference/6.2/analysis-ngram-tokenizer.html
        term_vector: 'with_positions_offsets_payloads',
        store: false,
        copy_to: ['completion']
      },
      HasEntityKeywords: {
        type: 'text',
        index: true,
        analyzer: 'my_ngram_tokenizer_analyzer', # https://www.elastic.co/guide/en/elasticsearch/reference/6.2/analysis-ngram-tokenizer.html
        term_vector: 'with_positions_offsets_payloads',
        copy_to: ['completion']
      },
      completion: {
	      fielddata: true, # That's why type: "text" is aggregatable. https://www.elastic.co/guide/en/elasticsearch/reference/current/fielddata.html
        type: 'text',
        analyzer: 'my_completion_analyzer'
      },
      HasEntityBlurb: {
        type: 'text',
        analyzer: 'my_ngram_tokenizer_analyzer', # https://www.elastic.co/guide/en/elasticsearch/reference/6.2/analysis-ngram-tokenizer.html
        term_vector: 'with_positions_offsets_payloads',
        store: false,
        copy_to: ['completion']
      },
      HasEntityContent: {
        type: 'text',
        fielddata: true,
        analyzer: 'my_ngram_tokenizer_analyzer', # https://www.elastic.co/guide/en/elasticsearch/reference/6.2/analysis-ngram-tokenizer.html
        term_vector: 'with_positions_offsets_payloads',
        store: false,
        copy_to: ['completion']
      },
      # Entity properties
      HasEntityAnnotations: {
        type: 'nested',
        include_in_root: true,
        properties: {
          HasAnnotationSubject: {
            type: 'keyword',
            index: false,
            store: false
          },
          HasAnnotationPredicate: {
            type: 'keyword',
            index: true,
            store: true,
            fields: {
              myNormalized: {
                type: 'text',
                analyzer: 'my_lowercase_analyzer',
                index: true,
                store: false
              }
            }
          },
          HasAnnotationPredicateURL: {
            type: 'text',
            index: true,
            store: false
          },
          HasAnnotationObjectURL: {
            type: 'keyword',
            index: false,
            store: false
          },
          HasAnnotationObjectHTMLATag: {
            type: 'keyword',
            index: false,
            store: false
          },
          HasAnnotationObjectValue: {
            type: 'text',
            store: true,
            index: true,
            analyzer: 'my_ngram_tokenizer_analyzer', # https://www.elastic.co/guide/en/elasticsearch/reference/6.2/analysis-ngram-tokenizer.html
            term_vector: 'with_positions_offsets_payloads',
            copy_to: ['HasEntityAnnotations.HasAnnotationObjectNotAnalyzedValue'],
            fields: {
              myNormalized: {
                type: 'keyword',
                normalizer: 'my_normalizer',
                index: true,
                store: false
              }
            }
          },
          HasAnnotationObjectNotAnalyzedValue: {
            type: 'keyword',
            store: true,
            index: true
          }
        }
      }
    }
  }
}.to_json
