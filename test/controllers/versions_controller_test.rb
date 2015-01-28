require 'test_helper'

class VersionsControllerTest < ActionController::TestCase
  def setup
    @word = create(:word)
    @word.update(body: 'Testtext to test the version')
    @user = create(:user)
  end

  test 'should show all versions' do
    get :index, id: @word.slug
    assert_template :index
  end

  test 'should create new version' do
    assert_difference('@word.versions.count') do
      @word.update(body: 'Another testtext for the version')
    end
  end

  test 'should revert version' do
    log_in_as(@user)
    get(:revert, id: @word.slug, version_id: @word.versions.last.id)
    assert_redirected_to word_path(@word)
  end
end
