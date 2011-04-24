# To change this template, choose Tools | Templates
# and open the template in the editor.

class PublicationsItemsController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @item = Publicationgroup.find_by_id(params[:id])
    @tab = "edit"
  end

  def show
    @tab = "edit"
    index
    render :action=>"index"
  end

  def new
    @tab = "edit"
    @item = Publicationitem.new(:publicationgroup_id=>params[:id])
  end

  def create
    new
    if request.post?
      @item.update_attributes(params[:item])
      if @item.save
        redirect_to :action=>"show", :id=>@item.publicationgroup.id
      end
    end
  end

  def edit
    @tab = "edit"
    @item = Publicationitem.find(params[:tid])
  end

  def save
    edit
    if request.post?
      @item.update_attributes(params[:item])
      if @item.save
        redirect_to :action=>"show", :id=>@item.publicationgroup.id
      end
    end
  end

  def delete
    edit
    if request.post?
      tmp_id = @item.publicationgroup.id
      redirect_to :action=>"show", :id=>tmp_id if @item.delete
    end
  end

end
