class <%= class_name %> < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "<%= file_name %>"
  title "extensiontitle"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "extensiongroup"
  visible false
  is_material false
  is_block false
  #block_engine ModuleBlockEngine
  #page_engine  PageEngine
  index_controller ""

  admin_index "admin/#{extension_group}/<%= file_name %>"

  define_routes do |map|
    #map.connect 'url', :controller => 'Controller', :action => 'action', :conditions=>{ :method=>:post}
    begin

    vopages = Page.all(:conditions=>{:contenttype=><%= class_name %>.extension_name})
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

  

  def foo; 1 end
end