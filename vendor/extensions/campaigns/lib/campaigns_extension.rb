class CampaignsExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "campaigns"
  title "Управление акциями"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "content"
  visible true
  is_material true
  is_block true
  block_engine CampaignsBlockEngine
  #page_engine  PageEngine
  index_controller "CampaignsPublic"

  admin_index "admin/#{extension_group}/campaigns"

  define_routes do |map|
    map.with_options( 
      :name_prefix => "admin_",
      :path_prefix => "admin/#{extension_group}",
      :requirements => {:id => /[0-9]+/}
    ) do |admin|
      admin.resources :campaigns, :as=>"campaigns"
    end
    
    begin
      vopages = Page.all(:conditions=>{:contenttype=>CampaignsExtension.extension_name})
      init_pages_routes(map)
    rescue Exception => e
      
    end
    
  end


  def add_to_route(routarr, page_url)
    routarr.with_options :url=>page_url do |pers|
      pers.with_options :controller=>index_controller do |cl|
        cl.connect "#{page_url}.:format", :action=>"index", :tab=>nil, :page=>"page-1"
      end
    end
  end

  

  def foo; 1 end
end