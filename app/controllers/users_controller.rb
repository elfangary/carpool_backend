class UsersController < ApplicationController
  before_action :authenticate_request!

  def show
    render json: current_user, status: :ok
  end

  # PATCH/PUT /users/1
  def update
      if current_user.update(user_params)
        render json: current_user
      else
        render json: current_user.errors, status: :unprocessable_entity
      end
  end

  # DELETE /users/1
  def destroy
    current_user.destroy
  end

  private
   def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone, :profile_pic, :gender, :chargedPoints)
   end
end
