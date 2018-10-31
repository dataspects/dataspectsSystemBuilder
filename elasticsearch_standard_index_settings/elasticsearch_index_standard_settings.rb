# "my_" indicates arbitrary customer naming!

@jsonSETTINGS = {
  settings: {
    index: {
      number_of_shards: 1,
      number_of_replicas: 1
    },
    analysis: {
      filter: {
        my_shingle_2: {
          type: 'shingle',
          output_unigrams: false
        }
      },
      analyzer: {
        my_lowercase_analyzer: {
          type: 'custom',
          tokenizer: 'standard',
          filter: 'lowercase'
        },
        my_ngram_tokenizer_analyzer: {
          type: 'custom',
          tokenizer: 'my_ngram_tokenizer',
          filter: 'lowercase'
        },
        my_completion_analyzer: {
          tokenizer: 'standard',
          filter: [
            'standard',
            'lowercase',
            'my_shingle_2'
          ]
        }
      },
      tokenizer: {
        my_ngram_tokenizer: {
          type: 'ngram',
          min_gram: 3,
          max_gram: 20,
          token_chars: [
            'letter',
            'digit',
            'punctuation'
          ]
        }
      },
      normalizer: {
        my_normalizer: {
          type: "custom",
          char_filter: [],
          filter: ["lowercase", "asciifolding"]
        }
      }
    }
  }
}.to_json
