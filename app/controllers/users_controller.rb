class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      msg = UserMailer.activation_email(@user)
      msg.deliver_now

      flash[:errors] = ["Please check your email to activate your account."]
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    if logged_in?
      render :show
    else
      redirect_to new_user_url
    end
  end

  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    if @user
      @user.activate!
      flash[:errors] = ["Account Activated! You can now log in!"]
      redirect_to new_session_url
    else
      flash[:errors] = ["Bad activation token"]
      redirect_to new_session_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
