require 'test_helper'

class WordsControllerTest < ActionController::TestCase
  def setup
    @word = create(:word)
    @user = create(:user)
    @non_admin = create(:other_user)
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
    assert_redirected_to search_path(query: 'Not-Existent')
  end

  test 'should get new' do
    log_in_as(@user)
    get :new
    assert_template :new
    assert_response :success
  end

  test 'should create word' do
    log_in_as(@user)
    assert_difference('Word.count', 1) do
      post :create, word: build(:word, title: 'New Word Title',
                                       language_id: 1).attributes
    end
    assert_redirected_to word_path(assigns(:word))
  end

  test 'should update word' do
    log_in_as(@user)
    patch :update, id: @word.slug, word: { title: 'New Title' }
    assert_redirected_to word_path(assigns(:word))
  end

  test 'should not update word with invalid data' do
    log_in_as(@user)
    patch :update, id: @word.slug, word: { title: '' }
    assert_template :edit
  end

  test 'should destroy word' do
    log_in_as(@user)
    assert_difference('Word.count', -1) do
      delete :destroy, id: @word.slug
    end
    assert_redirected_to words_path
  end

  test 'should not destroy word as non-admin' do
    @request.env['HTTP_REFERER'] = edit_user_path(@word)
    log_in_as(@non_admin)
    assert_no_difference 'Word.count' do
      delete :destroy, id: @word.slug
    end
  end
end
