# To change this template, choose Tools | Templates
# and open the template in the editor.

class PagedBlockTabsController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @group = Tabgroup.find_by_id(params[:id])
    @items = @group.tabitems
  end

  def new
    @group = Tabgroup.find_by_id(params[:id])
    @item = Tabitem.new(:tabgroup_id=>params[:id])
  end

  def create
    new
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action=>"index", :id=>@item.tabgroup.id
    end
  end

  def edit
    @group = Tabgroup.find_by_id(params[:id])
    @item = Tabitem.find_by_id(params[:tid])
  end

  def save
    edit
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action=>"index", :id=>@item.tabgroup.id
    end
  end

  def delete
    edit
    @tmp_id = @item.tabgroup.id
    if request.post?
      @item.delete
      redirect_to :action=>"index", :id=>@tmp_id
    end
  end
end
