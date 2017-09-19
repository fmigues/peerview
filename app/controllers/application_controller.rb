class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :date_of_birth, :description, :city, :classroom_id, :courses])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end


 before_action :configure_permitted_parameters, if: :devise_controller?

end
