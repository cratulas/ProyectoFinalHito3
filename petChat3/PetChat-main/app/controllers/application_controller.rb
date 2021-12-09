class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def current_order
      if current_user
          order = Order.where(user_id: current_user.id).where(status:"created").last
          if order.nil?
              order = Order.create(user: current_user, status: "created")
          end
          return order
      end
      nil
    end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :photo,:name,:descritpion, :photoVet])
    end

    def after_sign_in_path_for(resource)
      home_indexUser_path
    end
  
    def after_sign_out_path_for(resource)
      root_url
    end
end
