class FaqAdminController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required
  
  def index
    
  end
end