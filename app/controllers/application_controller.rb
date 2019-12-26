# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include PagesHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def login_verify
    redirect_to root_path unless user_signed_in?
  end
end
