class ApplicationController < ActionController::Base
    before_action :sign_out_user, if: :user_signed_in?
    
    protected
    
    def sign_out_user
      sign_out_and_redirect(current_user) if current_user.status == true
    end
end
