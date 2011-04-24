# To change this template, choose Tools | Templates
# and open the template in the editor.

class NavividgetAdminController < ApplicationController
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    
  end

  def newnav
    @newnav = Navigate.new
    if request.post?
      @newnav.update_attributes(params[:newnav])
      redirect_to :action=>"index"
    end
  end

  def editnav
    @editnav = Navigate.find params[:id]
    if request.post?
      @editnav.update_attributes(params[:editnav])
      redirect_to :action=>"index"
    end
  end
end
