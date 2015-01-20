$ ->
  words = new Bloodhound
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: '/_autocomplete?query=%QUERY'

  words.initialize();

  $('#word_search').typeahead null,
      name: 'word',
      displayKey: 'title',
      source: words.ttAdapter()