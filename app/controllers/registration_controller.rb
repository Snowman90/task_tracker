# frozen_string_literal: true

class RegistrationController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.activation_token = SecureRandom.uuid
    if user.save
      RegistrationMailer.activate(user).deliver_later
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def activate
    user = User.find_by!(activation_token: params[:activation_token])
    user.activate!
    session[:current_user_id] = user.id
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
