require 'test_helper'

class WordsControllerTest < ActionController::TestCase
  def setup
    @word = create(:word)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:words)
  end

  test 'should get show with existing Word' do
    get :show, id: @word.slug
    assert_response :success
    assert_not_nil assigns(:word)
  end

  test 'should redirect to search if Word does not exist' do
    get :show, id: 'Not-Existent'
    assert_redirected_to search_words_path(query: 'Not-Existent')
  end

  test 'should get new' do
    get :new
    assert_template :new
    assert_response :success
  end

  test 'should create word' do
    assert_difference('Word.count', 1) do
      post :create, word: build(:word, title: 'New Word Title',
                                       language_id: 1).attributes
    end
    assert_redirected_to word_path(assigns(:word))
  end

  test 'should update word' do
    patch :update, id: @word.slug, word: { title: 'New Title' }
    assert_redirected_to word_path(assigns(:word))
  end

  test 'should not update word with invalid data' do
    patch :update, id: @word.slug, word: { title: '' }
    assert_template :edit
  end

  test 'should destroy word' do
    assert_difference('Word.count', -1) do
      delete :destroy, id: @word.slug
    end
    assert_redirected_to words_path
  end
end
