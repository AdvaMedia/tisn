# To change this template, choose Tools | Templates
# and open the template in the editor.

class GlobalSettingsController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required
 
  def index
    @item = SiteGlobalSettings.new
    if request.post?
      @item.update_attributes params[:item]
      @item = SiteGlobalSettings.new
    end
  end
end
