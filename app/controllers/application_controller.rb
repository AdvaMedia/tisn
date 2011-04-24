# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  attr_accessor :page
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  

  def authorize
    unless User.find_by_id(session['user_id'])
      session[:original_url]=request.request_uri
      flash[:notice]="Для доступа, пожалуйста пройдите авторизацию"
      redirect_to(:controller=>"welcome", :action=>"index")
    end
  end

  def adminuser
    unless current_user.has_role("Admins")
      redirect_to(:controller=>"welcome", :action=>"index")
    end
  end


  def activeuser
    current_user
  end

  def self_flash
    flash
  end

   
end
