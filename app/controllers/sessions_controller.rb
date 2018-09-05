# frozen_string_literal: trues

class SessionsController < ApplicationController
  before_action :find_user, only: %i[create]

  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      log_in @user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def find_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end

  def log_in(user)
    session[:current_user_id] = user.id
  end

  def log_out
    session.delete(:current_user_id)
    @current_user = nil
  end
end
