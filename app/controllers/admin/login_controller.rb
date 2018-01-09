class Admin::LoginController < ApplicationController

  def create
    admin = Admin.find_by(email: params[:email]) 
    # authenticate is pre-defined in bcrypt which is hashed the password
    if admin && admin.authenticate(params[:password])
      render json: responseObj(admin), status: :ok
    else
      render json: {message: 'Invalid email/password'}, status: :unauthorized
    end
  end

  private
  def responseObj(admin)
  {
    auth_token: JsonWebToken.encode({admin_id: admin.id}),
    admin: {id: admin.id, fullName: admin.fullName, email: admin.email}
  }
  end
end
