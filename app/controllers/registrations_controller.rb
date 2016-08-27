class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json

   protected
  def after_update_path_for(resource)
    user_path(resource)
  end
end
