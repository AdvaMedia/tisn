# To change this template, choose Tools | Templates
# and open the template in the editor.

class PagedBlockAdminController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    
  end
end
