#        admin_yandex_photos GET    /admin/content/yandex_maps/photos(.:format)               {:controller=>"yandex_photos", :action=>"index"}
#                            POST   /admin/content/yandex_maps/photos(.:format)               {:controller=>"yandex_photos", :action=>"create"}
#     new_admin_yandex_photo GET    /admin/content/yandex_maps/photos/new(.:format)           {:controller=>"yandex_photos", :action=>"new"}
#    edit_admin_yandex_photo GET    /admin/content/yandex_maps/photos/:id/edit(.:format)      {:controller=>"yandex_photos", :action=>"edit"}
# move_to_admin_yandex_photo GET    /admin/content/yandex_maps/photos/:id/move_to(.:format)   {:controller=>"yandex_photos", :action=>"move_to"}
#         admin_yandex_photo GET    /admin/content/yandex_maps/photos/:id(.:format)           {:controller=>"yandex_photos", :action=>"show"}
#                            PUT    /admin/content/yandex_maps/photos/:id(.:format)           {:controller=>"yandex_photos", :action=>"update"}
#                            DELETE /admin/content/yandex_maps/photos/:id(.:format)           {:controller=>"yandex_photos", :action=>"destroy"}

class YandexPhotosController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @map_images = []
    unless params[:map_address_id].blank?
      @map_address = MapAddress.find(params[:map_address_id])
      @office_images = @map_address.office_images
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @map_address}
    end
  end

  def new
    @hide_upload = false
    @map_address = MapAddress.find(params[:map_address_id])
    @office_image = OfficeImage.new(:map_address_id=>params[:map_address_id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @map_address }
    end
  end

  def create
    @map_address = MapAddress.find_by_id(params[:office_image][:map_address_id])
    @office_image = OfficeImage.new(params[:office_image])
    
    respond_to do |format|
      if @office_image.save
        format.html { redirect_to(admin_yandex_photos_path(:map_address_id=>@map_address.id), :notice => 'Office photo was successfully created.') }
        format.xml  { render :xml => @office_image, :status => :created, :location => @office_image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @office_image.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    edit

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @office_image }
    end
  end
  
  def edit
    @hide_upload = true
    @office_image = OfficeImage.find(params[:id])
  end
  
  def update
    edit
    respond_to do |format|
      if @office_image.update_attributes(params[:office_image])
        format.html { redirect_to(admin_yandex_photos_path(:map_address_id=>@office_image.map_address.id), :notice => 'Office image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @office_image.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
   edit
    tmp_rid = @office_image.map_address.id
    @office_image.destroy

    respond_to do |format|
      format.html { redirect_to(admin_yandex_photos_path(:map_address_id=>tmp_rid)) }
      format.xml  { head :ok }
    end
  end
  
  def move_to
    begin
      edit
      case params[:direction]
      when "up"
        @office_image.move_higher
      when "down"
        @office_image.move_lower
      end  
    rescue Exception => e
      
    end
    
    respond_to do |format|
      format.html { redirect_to(admin_yandex_photos_path(:map_address_id=>@office_image.map_address.id)) }
      format.xml  { head :ok }
    end
  end
end
