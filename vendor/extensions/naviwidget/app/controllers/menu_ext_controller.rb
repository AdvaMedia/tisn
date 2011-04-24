# To change this template, choose Tools | Templates
# and open the template in the editor.

class MenuExtController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required
  
  def index
    @items = Navigate.all
    @tab="list"
  end

  def show
    @tab="edit"
    @item = Navigate.find_by_id(params[:id]) unless params[:id].blank?
  end

  def new
    @tab="list"
    @item = Navigate.new
  end

  def create
    new
    @item.update_attributes(params[:item])
    redirect_to :action=>"index"
  end

  def edit
    @tab="list"
    @item = Navigate.find_by_id(params[:id])
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
      redirect_to :action=>"index"
    end
  end

  def select_menu
    @item = Menublock.find_by_id(params[:id])
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action=>"index", :controller=>"PageblocksExt"
    end
  end

  #Для редактирования веток меню

  def new_node
    @tab="edit"
    @item = Navinode.new(:navigate_id=>params[:id])
  end

  def create_node
    new_node
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action=>"show", :id=>@item.navigate.id
    end
  end

  def edit_node
    @tab="edit"
    @item = Navinode.find_by_id(params[:tid])
  end

  def save_node
    edit_node
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action=>"show", :id=>@item.navigate.id
    end
  end

  def delete_node
    @tab="edit"
  end

  def toggle_node
    edit_node
    @item.aexpanded = !@item.aexpanded
    @item.save
    redirect_to :action=>"show", :id=>@item.navigate.id
  end

  def toggle_node_visible
    edit_node
    @item.enabled = !@item.enabled
    @item.save
    redirect_to :action=>"show", :id=>@item.navigate.id
  end
end
