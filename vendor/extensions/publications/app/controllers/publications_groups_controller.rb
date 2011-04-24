# To change this template, choose Tools | Templates
# and open the template in the editor.

class PublicationsGroupsController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @items = Publicationgroup.all
    @tab = "list"
  end

  def new
    @item = Publicationgroup.new
    @tab = "list"
  end

  def create
    new
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action=>"index"
    end
  end

  def edit
    @item = Publicationgroup.find_by_id(params[:id])
    @tab = "list"
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
      @item.destroy
      redirect_to :action=>"index"
    end
  end

  def set_to_page
    @item = init_page_association
    if request.post?
      flash[:notice] = "Настройка страницы изменена" if @item.update_attributes(params[:item])
    end
  end

  def set_to_block
    @item = init_block_association
    if request.post?
      flash[:notice] = "Настройка блока изменена" if @item.update_attributes(params[:item])
    end
  end

  private
  def init_page_association
    result = Publicationpage.find(:first, :conditions=>{:page_id=>params[:id]})
    if result.blank?
      result = Publicationpage.new(:page_id=>params[:id])
    end
    flash[:notice]=nil
    result
  end

  def init_block_association
    result = Publicationblock.find(:first, :conditions=>{:pageblock_id=>params[:id]})
    if result.blank?
      result = Publicationblock.new(:pageblock_id=>params[:id])
    end
    flash[:notice]=nil
    result
  end
end
