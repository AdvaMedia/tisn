class YandexMapsExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "yandex_maps"
  title "Офисы на карте"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "content"
  visible true
  is_material false
  is_block true
  block_engine YandexMapsBlockEngine
  #page_engine  PageEngine
  index_controller ""

  admin_index "admin/#{extension_group}/yandex_maps"

  define_routes do |map|
    #map.connect 'url', :controller => 'Controller', :action => 'action', :conditions=>{ :method=>:post}
    map.with_options( 
      :name_prefix => "admin_",
      :member => { 
        :move_to => :get 
      },
      :requirements => {:id => /[0-9]+/}
    ) do |admin|
      admin.resources :yandex_maps, :path_prefix => "admin/#{extension_group}"
      [:yandex_maps].map{|itm| itm = "admin/#{extension_group}/#{itm}"}.each do |adm_prefix|
        admin.resources :yandex_adresses, :as=>"adresses", :path_prefix => adm_prefix
        admin.resources :yandex_photos, :as=>"photos", :path_prefix => adm_prefix
      end
    end
    begin

    vopages = Page.all(:conditions=>{:contenttype=>YandexmapsExtension.extension_name})
      init_pages_routes(map)
      rescue Exception=>ex
    end
  end


  def add_to_route(routarr, page_url)
    routarr.with_options :url=>page_url do |pers|
      pers.with_options :controller=>index_controller do |cl|
        #cl.connect "#{page_url}.:format", :action=>"index", :tab=>nil, :page=>"page-1"
      end
    end
  end

  def yandex_key
    #"AE9No00BAAAADp2DDgIA-6thWwv2zeGK4zyTL-iIsNRAKhYAAAAAAAAAAADQLw7U6jVocMlvcJK3dngBN3pMyQ=="
    "ABOtrE0BAAAArzoCTgMAEkN4jxLJTxYAwvEVXMWWS2-7psoAAAAAAAAAAAD2El3MfuQsBQ2l6q3R8y2hetfGnA=="
  end

  def foo; 1 end
end
