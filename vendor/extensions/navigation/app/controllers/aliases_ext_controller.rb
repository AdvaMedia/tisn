# To change this template, choose Tools | Templates
# and open the template in the editor.

class AliasesExtController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @links = Pagealias.all(:conditions=>{:page_id=>params[:id]})
  end

  def new
    unless params[:id].blank?
      @link = Pagealias.new(:page_id=>params[:id])
    end
  end

  def create
    @link = Pagealias.new
    if @link.update_attributes(params[:link])
      redirect_to :action=>"index", :id=>@link.page.id
    end
  end

  def edit
    @link = Pagealias.find_by_id(params[:id])
  end

  def update
    edit
    if @link.update_attributes(params[:link])
      redirect_to :action=>"index", :id=> @link.page.id
    end
  end

  def destroy
    predestroy
    pageid = @link.page.id
    if @link.destroy
      redirect_to :action=>"index", :id=> pageid
    end
  end

  def predestroy
    edit
  end
end
