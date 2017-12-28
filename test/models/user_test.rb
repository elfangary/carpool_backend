require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user vaild" do
    user= User.new(user_params)
    
    assert user.save!
  end
end
