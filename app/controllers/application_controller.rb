class ApplicationController < ActionController::Base
    protect_from_forgery
    before_action :authenticate_user!
    before_action :header_name
    before_action :configure_permitted_parameters, if: :devise_controller?

    def header_name
        if user_signed_in?
            @header = current_user.name
        else
            @header = "ゲスト"
        end
    end

    def after_sign_in_path_for(resource)
        user_path(resource)
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
    end
end
