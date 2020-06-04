class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      flash[:success] = t "auth.success"
      log_in user
    else
      flash[:danger] = t "auth.incorrect"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end