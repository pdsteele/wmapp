class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimplestAuth::Controller

  include SessionsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out_
    super
  end

  
end
