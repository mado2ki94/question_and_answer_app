class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  # alias_method :devise_current_user, :current_user
  # def current_user
  #   if devise_current_user.nil?
  #     User.new
  #   else
  #     User.find_by(id: devise_current_user.id)
  #   end
  # end
end
