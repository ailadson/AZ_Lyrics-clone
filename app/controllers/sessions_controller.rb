class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
                params[:user][:email],
                params[:user][:password]
    )

    if @user

      if @user.activated
        login!(@user)
        redirect_to user_url(@user)
      else
        flash.now[:errors] = ["Account not activated"]
        render :new
      end

    else
      flash.now[:errors] = ["Invalid Login"]
      render :new
    end
  end

  def destroy
    logout!(current_user)
    redirect_to new_session_url
  end
end
