require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = create(:user)
    @non_admin = create(:other_user)
  end

  test 'index as admin and delete links' do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', user_path(@non_admin), text: @non_admin.name
    unless @non_admin == @admin
      assert_select 'a[href=?]',  user_path(@non_admin),
                    text: 'Delete',
                    method: :delete
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test 'index as non-admin' do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
