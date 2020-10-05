class SessionsController < ApplicationController
  before_action :authenticated?, only: [:destory]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(user_params)
    if @user
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      flash[:alert] = 'the given name is not exist.'
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to new_session_path
  end

  def user_params
    params.require(:user).permit(:name)
  end
end

