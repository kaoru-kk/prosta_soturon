# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :header_name
  before_action :configure_permitted_parameters, if: :devise_controller?

  def header_name
    @header = if user_signed_in?
                current_user.name
              else
                'ゲスト'
              end
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image])
  end
end
