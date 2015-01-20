require 'test_helper'

class WordsControllerTest < ActionController::TestCase

  def setup
    @lang = Language.create(name: 'Testlang', code: 'TL')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:words)
  end

  test "should get show with existing Word" do
    @test_word = Word.create title: "Test-Title", body: "Some Text for the Test.", language_id: @lang.id
    get :show, id: 'Test-Title'
    assert_template :show
    assert_response :success
    assert_not_nil assigns(:word)
  end

  test "should render new if Word does not exist" do
    get :show, id: 'Not-Existent'
    assert_template :new
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_template :new
    assert_response :success
  end

  test "should create word" do
    assert_difference('Word.count') do
      post :create, word: { title: 'Test Title', body: 'Some Text for the body.', language_id: @lang.id }
    end

    assert_redirected_to word_path(assigns(:word))
  end

  test "should update word" do
    @test_word = Word.create title: "Test Title", body: "Test body for the Test of Update.", language_id: @lang.id

    patch :update, id: @test_word.id, word: { :title => "New Title" }
    assert_not_nil Word.find('New_Title')
    assert_equal 'New Title', Word.find('New_Title').title
    assert_redirected_to word_path(assigns(:word))
  end

  test "should not update word with invalid data" do
    @test_word = Word.create title: "Test Title", body: "Test body for the Test of Update.", language_id: @lang.id

    patch :update, id: @test_word.id, word: { :title => "" }
    assert_template :edit, id: @test_word.id
  end

  test "should destroy word" do
    @test_word = Word.create title: "Test Title", body: "Test body for the Test of Update.", language_id: @lang.id

    assert_difference('Word.count', -1) do
      delete :destroy, id: @test_word.id
    end
    assert_redirected_to words_path
  end

end