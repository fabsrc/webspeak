require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  def setup
    @lang = build(:testlanguage)
  end

  test 'should not save language without name' do
    @lang.name = nil
    assert_not @lang.save
    assert_not_includes Language.all, @lang
  end

  test 'should not save language without code' do
    @lang.code = nil
    assert_not @lang.save
    assert_not_includes Language.all, @lang
  end

  test 'should not save language if already exists' do
    @lang.save
    @same_lang = build(:testlanguage)
    assert_not @same_lang.save
    assert_not_includes Language.all, @same_lang
  end

  test 'should not save language with wrong code' do
    @lang.code = 'TEST'
    assert_not @lang.save
    assert_not_includes Language.all, @lang
  end

  test 'should save language with right data' do
    assert @lang.save
    assert_includes Language.all, @lang
  end

  test 'should save language with right data and upcase code' do
    @lang.code = 'de'
    @lang.save
    assert_equal 'DE', @lang.code
  end
end
