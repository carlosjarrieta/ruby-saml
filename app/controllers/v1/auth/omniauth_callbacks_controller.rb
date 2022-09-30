# https://github.com/lynndylanhurley/devise_token_auth/blob/master/app/controllers/devise_token_auth/omniauth_callbacks_controller.rb
class V1::Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, raise: false

  def saml
    begin
      response_params = request.env['omniauth.auth']['info']
      @user = User.find_by!(email: response_params['email'])

      if @user&.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        flash.now[:danger] = 'You have not yet an account!'
        # redirect_back(fallback_location: root_path)
      end
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.debug "User does not exist, email: " + response_params['email']
      redirect_to new_user_session_path, alert: "No existe el usuario"
    end

  end
end