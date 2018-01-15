class Admin::RegestrationController < ApplicationController

  def create
    @admin = Admin.new admin_params
    if @admin.save
      render json: @admin, status: :created
    else
      render json: {message: 'You cant not be created'}, status: :unauthorized
    end
  end

  private
  def admin_params
    params.permit(:fullName, :email, :password, :password_confirmation)
  end
end
