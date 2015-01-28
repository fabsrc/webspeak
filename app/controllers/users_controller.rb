class UsersController < ApplicationController
  before_action :logged_in_user,
                only: [:edit, :update, :index, :destroy]
  before_action :correct_user_or_admin,
                only: [:edit, :update, :destroy]
  before_action :find_user,
                only: [:correct_user_or_admin, :update, :edit, :show, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user_or_admin, only: [:edit, :update, :destroy]

  def index
    @users = User.ordered.group_by { |user| user.name[0].upcase }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to @user, flash: { success: 'Welcome to Webspeak' }
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, flash: { success: 'Profile updated.' }
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, flash: { success: 'User deleted.' }
  end

  def user_params
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation)
  end

  def correct_user_or_admin
    return if admin? || current_user?(@user)
    redirect_to root_path,
                flash: { danger: 'You have to be an Administrator.' }
  end

  def find_user
    @user = User.find(params[:id])
  end

  private :user_params, :find_user, :correct_user_or_admin
end
