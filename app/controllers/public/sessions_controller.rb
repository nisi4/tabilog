# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state,only: [:create]
  
  def new_guest
    user = User.guest
    sign_in user  #ユーザーをログインさせる
    redirect_to root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
    
    
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  
  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if (@user.valid_password?(params[:user][:password])) && (@user.status == true)
      redirect_to new_user_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
end
