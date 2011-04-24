# To change this template, choose Tools | Templates
# and open the template in the editor.

class MenuTempateController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @tab="list"
    @items = Menutemplate.all(:conditions=>{:navigate_id=>params[:id]})
  end

  def new
    @tab="list"
    @item = Menutemplate.new(:navigate_id=>params[:id])
  end

  def create
    new
    @item.update_attributes(params[:item])
    redirect_to :action=>"index"
  end

  def edit
    @tab="list"
    @item = Menutemplate.find_by_id(params[:tid])
  end

  def save
    edit
    @item.update_attributes(params[:item])
    redirect_to :action=>"index"
  end

  def delete
    edit
    if request.post?
      @item.delete
      Menutemplate.destroy_all(:navigate_id=>nil)
      redirect_to :action=>"index"
    end
  end
end
