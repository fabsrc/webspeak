require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'should not save language without name' do
    language = Language.new(code: 'DE')
    assert_not language.save
    assert_not_includes Language.all, language
  end

  test 'should not save language without code' do
    language = Language.new(name: 'German')
    assert_not language.save
    assert_not_includes Language.all, language
  end

  test 'should not save language if already exists' do
    Language.create(name: 'German', code: 'de')
    language = Language.new(name: 'German', code: 'de')
    assert_not language.save
    assert_not_includes Language.all, language
  end

  test 'should not save language with wrong code' do
    language = Language.new(name: 'German', code: 'DEU')
    assert_not language.save
    assert_not_includes Language.all, language
  end

  test 'should save language with right data' do
    language = Language.new(name: 'German', code: 'de')
    assert language.save
    assert_includes Language.all, language
  end

  test 'should save language with right data and upcase code' do
    language = Language.create(name: 'German', code: 'de')
    assert_includes Language.all, language
    assert_equal 'DE', language.code
  end
end
