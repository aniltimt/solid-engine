class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :mailbox, :conversation
  
  before_action :check_user_status
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  protected

  def check_user_status
  	if user_signed_in?
  	  if current_user.status == nil
  	  	sign_out current_user
  	  	redirect_to :back, :alert => "Your account is not ready yet, please try after some time."
  	  elsif current_user.status == 0
  	  	sign_out current_user  	  	
  	  	redirect_to root_path, :alert => "Your account is not approved by admin, please contact to Admin."
  	  end
  	end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end
end
