# To change this template, choose Tools | Templates
# and open the template in the editor.

class PagedBlockGroupController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @items = Tabgroup.all
  end

  def new
    @item = Tabgroup.new
  end

  def create
    new
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action=>"index"
    end
  end

  def edit
    @item = Tabgroup.find_by_id(params[:id])
  end

  def save
    edit
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action=>"index"
    end
  end

  def delete
    edit
    if request.post?
      @item.delete
      redirect_to :action=>"index"
    end
  end
end
