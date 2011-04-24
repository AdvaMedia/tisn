#      admin_yandex_adresses GET    /admin/content/yandex_maps/adresses(.:format)             :action=>"index"
#                            POST   /admin/content/yandex_maps/adresses(.:format)             :action=>"create"
#    new_admin_yandex_adress GET    /admin/content/yandex_maps/adresses/new(.:format)         :action=>"new"
#   edit_admin_yandex_adress GET    /admin/content/yandex_maps/adresses/:id/edit(.:format)    :action=>"edit"
#move_to_admin_yandex_adress GET    /admin/content/yandex_maps/adresses/:id/move_to(.:format) :action=>"move_to"
#        admin_yandex_adress GET    /admin/content/yandex_maps/adresses/:id(.:format)         :action=>"show"
#                            PUT    /admin/content/yandex_maps/adresses/:id(.:format)         :action=>"update"
#                            DELETE /admin/content/yandex_maps/adresses/:id(.:format)         :action=>"destroy"

class YandexAdressesController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required
  
  # GET /map_regions
  # GET /map_regions.xml
  def index
    @map_addresses = []
    unless params[:map_region_id].blank?
      @map_region = MapRegion.find(params[:map_region_id])
      @map_addresses = @map_region.map_adresses
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @map_addresses }
    end
  end
  
  def new
    @map_region = MapRegion.find_by_id(params[:map_region_id])
    @map_address = MapAddress.new(:map_region_id=>params[:map_region_id], :country => "Россия" )
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @map_address }
    end
  end
  
  def create
    @map_region = MapRegion.find_by_id(params[:map_address][:map_region_id])
    @map_address = MapAddress.new(params[:map_address])
    
    respond_to do |format|
      if @map_address.save
        format.html { redirect_to(admin_yandex_adresses_path(:map_region_id=>@map_region.id), :notice => 'Map region was successfully created.') }
        format.xml  { render :xml => @map_address, :status => :created, :location => @map_address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @map_address.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @map_address = MapAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @map_address }
    end
  end
  
  def edit
    @map_address = MapAddress.find(params[:id])
  end
  
  def update
    @map_address = MapAddress.find(params[:id])
    respond_to do |format|
      if @map_address.update_attributes(params[:map_address])
        format.html { redirect_to(admin_yandex_adresses_path(:map_region_id=>@map_address.map_region.id), :notice => 'Map address was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @map_address.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @map_address = MapAddress.find(params[:id])
    tmp_rid = @map_address.map_region.id
    @map_address.destroy

    respond_to do |format|
      format.html { redirect_to(admin_yandex_adresses_path(:map_region_id=>tmp_rid)) }
      format.xml  { head :ok }
    end
  end
  
  def move_to
    begin
      @map_adress = MapAddress.find(params[:id])
      case params[:direction]
      when "up"
        @map_adress.move_higher
      when "down"
        @map_adress.move_lower
      end  
    rescue Exception => e
      
    end
    
    respond_to do |format|
      format.html { redirect_to(admin_yandex_adresses_path(:map_region_id=>@map_adress.map_region.id)) }
      format.xml  { head :ok }
    end
  end
end