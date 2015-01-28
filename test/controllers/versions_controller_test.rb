require 'test_helper'

class VersionsControllerTest < ActionController::TestCase
  def setup
    @word = create(:word)
    @word.update(body: 'Testtext to test the version')
  end
  
  test 'should get all versions' do
  end
  
  test 'should revert version' do
  end
end
