require 'test_helper'

class WordTest < ActiveSupport::TestCase
  def setup
    @word = build(:word)
    @lang = build(:testlanguage)
  end

  test 'Word should be created with right data' do
    assert @word.save
    assert_includes Word.all, @word
  end

  test 'Word should not be created if text is too short' do
    @word.body = 'Too short...'
    assert_not @word.save
    assert_not_includes Word.all, @word
  end

  test 'Word without title should not be created' do
    @word.title = ''
    assert_not @word.save
    assert_not_includes Word.all, @word
  end

  test 'Word without body should not be created' do
    @word.body = ''
    assert_not @word.save
    assert_not_includes Word.all, @word
  end

  test 'Word without language should not be created' do
    @word.language = nil
    assert_not @word.save
    assert_not_includes Word.all, @word
  end

  test 'slug of Word should be created right' do
    @word.title = 'This-is A SLUG T3st!'
    assert @word.save
    assert_equal 'This-is_A_SLUG_T3st!', @word.slug
  end

  test 'should create translation of language' do
    @translated_word = build(:translated_word)
    @translated_word.save
    @word.translations << @translated_word
    @word.save
    assert_not_empty @word.translations
    assert_includes @word.translations, @translated_word
  end
end
