class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # 指定されている要素のみでログインできる記述
      # username == 'admin!' && password == '2222'
      # 環境変数を読み込む記述
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, user_keys
    devise_parameter_sanitizer.permit(:account_update, user_keys)
  end
  def user_keys
    [:nickname, :first_name, :last_name, :read_first, :read_last, :birthday]
  end
end
