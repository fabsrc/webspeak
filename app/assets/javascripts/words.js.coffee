# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  words = new Bloodhound
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    #prefetch: '../data/films/post_1960.json',
    remote: '/autocomplete?query=%QUERY'
    
  words.initialize();
  
  $('#word_search').typeahead null,
      name: 'word',
      displayKey: 'title',
      source: words.ttAdapter() 