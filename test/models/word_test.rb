require 'test_helper'

class WordTest < ActiveSupport::TestCase
  
  test "Word should be created with right data" do
    right_word = { title: "My Test Title", body: "This Text must be at least 20 characters long." }  
    test_right_word = Word.new right_word
    assert test_right_word.save
    assert_includes Word.all, test_right_word
  end
  
  test "Word should not be created if text is too short" do
    too_short_text = { title: "My Test Title", body: "Too short" }
    test_too_short_text = Word.new too_short_text
    assert_not test_too_short_text.save
    assert_not_includes Word.all, test_too_short_text
  end
  
  test "Word without title should not be created" do
    no_title = { title: "", body: "There is no title, so the word cannot be saved!" }
    test_no_title = Word.new no_title
    assert_not test_no_title.save
    assert_not_includes Word.all, test_no_title
  end
  
  test "Word without body should not be created" do
    no_body = { title: "My Test Title", body: "" }
    test_no_body = Word.new no_body
    assert_not test_no_body.save
    assert_not_includes Word.all, test_no_body
  end
  
  test "Slug of Word should be created right" do
    is_slug_right = { title: "This-is A SLUG T3st!", body: "The Slug should be transformed right!" }
    test_is_slug_right = Word.create is_slug_right
    assert_equal "This-is_A_SLUG_T3st!", test_is_slug_right.slug
  end
  
end
