class RegistrationsController < ApplicationController

  def create
    @user = User.new user_params
    if @user.save
      render json: @user, status: :created
    else
      render json: {message: 'You entered something wrong'}, status: :unauthorized
    end
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation, :profile_pic, :gender)
  end

end
