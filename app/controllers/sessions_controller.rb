class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email]) 
    # authenticate is pre-defined in bcrypt which is hashed the password
    if user && user.authenticate(params[:password])
      render json: responseObj(user), status: :ok
    else
      render json: {message: 'Invalid email/password'}, status: :unauthorized
    end
  end

  private
  def responseObj(user)
  {
    auth_token: JsonWebToken.encode({user_id: user.id}),
    user: {first_name: user.first_name, last_name: user.last_name, email: user.email, phone: user.phone, profile_pic: user.profile_pic, gender: user.gender, rate: user.rate, points: user.points}
  }
  end

end
