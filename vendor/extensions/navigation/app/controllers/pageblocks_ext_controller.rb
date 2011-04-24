# To change this template, choose Tools | Templates
# and open the template in the editor.

class PageblocksExtController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @page=Page.find_by_id(params[:page])
    if @page
      @regions = @page.regions.select{|region| region}
    else
      @regions = A2mCms::TemplatesLoader.all_regions("region")
    end
    @disabled_blocks = Pageblock.all(:conditions=>{:region_name=>""})
  end

  def new
    get_regions
    @item = Pageblock.new
  end

  def create
    new
    if request.post?
      if @item.update_attributes(params[:item])
        redirect_to :action=>"index"
      else
        render :action=>"new"
      end
    end
  end

  def edit
    get_regions
    @item = Pageblock.find_by_id(params[:id])
  end

  def save
    edit
    if request.post?
      if @item.update_attributes(params[:item])
        redirect_to :action=>"index"
      else
        render :action=>"edit"
      end
    end
  end

  def delete
    edit
    if request.post?
      @item.engine.delete(@item)
      @item.delete
      redirect_to :action=>"index"
    end
  end

  private
  def get_regions
    @regions = []
    A2mCms::TemplatesLoader.all_regions("region").each do |region|
      @regions << PageRegion.new(region, nil)
    end
  end
end
