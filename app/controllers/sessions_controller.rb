class SessionsController < ApplicationController
  def new
  end

  def create
    entered_email = params["email"]
    entered_password = params["password"]
    @user = User.find_by({email: entered_email})
    if @user
      if BCrypt::Password.new(@user.password) == entered_password
        session["user_id"] = @user.id
        redirect_to "/places"
      else
        flash[:notice] = "Incorrect Login"
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "Incorrect Login"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash[:notice] = "Logged Out!" 
    redirect_to "/sessions/new"
  end
end
  