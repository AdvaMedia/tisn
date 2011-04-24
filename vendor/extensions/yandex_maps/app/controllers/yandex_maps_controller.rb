#YandexMapsRegionsManagment

# admin_yandex_maps GET         /admin/content/yandex_maps(.:format)          :action=>"index"
#                       POST    /admin/content/yandex_maps(.:format)          :action=>"create"
#  new_admin_yandex_map GET     /admin/content/yandex_maps/new(.:format)      :action=>"new"
# edit_admin_yandex_map GET     /admin/content/yandex_maps/:id/edit(.:format) :action=>"edit"
#      admin_yandex_map GET     /admin/content/yandex_maps/:id(.:format)      :action=>"show"
#                       PUT     /admin/content/yandex_maps/:id(.:format)      :action=>"update"
#                       DELETE  /admin/content/yandex_maps/:id(.:format)      :action=>"destroy"

class YandexMapsController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required
  
  # GET /map_regions
  # GET /map_regions.xml
  def index
    @map_regions = MapRegion.all(:order => "position ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @map_regions }
    end
  end

  # GET /map_regions/1
  # GET /map_regions/1.xml
  def show
    @map_region = MapRegion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @map_region }
    end
  end

  # GET /map_regions/new
  # GET /map_regions/new.xml
  def new
    @map_region = MapRegion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @map_region }
    end
  end

  # GET /map_regions/1/edit
  def edit
    @yandex_region = MapRegion.find(params[:id])
  end

  # POST /map_regions
  # POST /map_regions.xml
  def create
    @map_region = MapRegion.new(params[:map_region])

    respond_to do |format|
      if @map_region.save
        format.html { redirect_to(admin_yandex_maps_path, :notice => 'Map region was successfully created.') }
        format.xml  { render :xml => @map_region, :status => :created, :location => @map_region }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @map_region.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /map_regions/1
  # PUT /map_regions/1.xml
  def update
    @yandex_region = MapRegion.find(params[:id])

    respond_to do |format|
      if @yandex_region.update_attributes(params[:yandex_region])
        format.html { redirect_to(admin_yandex_maps_path, :notice => 'Map region was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @map_region.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /map_regions/1
  # DELETE /map_regions/1.xml
  def destroy
    @map_region = MapRegion.find(params[:id])
    @map_region.destroy

    respond_to do |format|
      format.html { redirect_to(admin_yandex_maps_path) }
      format.xml  { head :ok }
    end
  end
  
  def move_to
    begin
      redirect_to(admin_yandex_maps_path) if params[:id].blank?
      @map_region = MapRegion.find(params[:id])
      case params[:direction]
      when "up"
        @map_region.move_higher
      when "down"
        @map_region.move_lower
      end  
    rescue Exception => e
      
    end
    
    respond_to do |format|
      format.html { redirect_to(admin_yandex_maps_path) }
      format.xml  { head :ok }
    end
  end
end