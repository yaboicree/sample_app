require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:michael) #same as other tests.... user from our fixture
  end

  test "unsuccessful edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	patch user_path, user: { name:  "",
                             email: "foo@invalid",
                             password:              "foo",
                             password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  test "successful edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	name = "binger"
  	email = "bing@bing.com"
  	patch user_path, user: {name: name, email: email, 
  													password: "", password_confirmation: ""}
  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal email, @user.email
  	assert_equal name, @user.name
  end

  test "successful edit with friendly forwarding..." do
  	get edit_user_path(@user)
  	log_in_as(@user)
  	assert_redirected_to edit_user_path(@user)
  	name = "binger"
  	email = "bing@bing.com"
  	patch user_path(@user), user: {name: name, email: email, 
  													password: "", password_confirmation: ""}
  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal email, @user.email
  	assert_equal name, @user.name
  end
end