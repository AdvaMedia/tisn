class FaqExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "faq"
  title "Вопросы и ответы"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "mail"
  visible true
  is_material true
  is_block false
  #block_engine ModuleBlockEngine
  page_engine  FaqPageEngine
  index_controller "Faq"

  admin_index "admin/#{extension_group}/faq"

  define_routes do |map|
    #map.connect 'url', :controller => 'Controller', :action => 'action', :conditions=>{ :method=>:post}
    map.with_options :controller=>"FaqAdmin" do |admin|
      admin.connect "/#{admin_index}", :action=>"index"
      admin.connect "/#{admin_index}/set_to_page", :action=>"set_to_page"
      admin.connect "/#{admin_index}/edit/:id", :action=>"edit"
      admin.connect "/#{admin_index}/save/:id", :action=>"save"
    end
    begin

    vopages = Page.all(:conditions=>{:contenttype=>FaqExtension.extension_name})
      init_pages_routes(map)
      rescue Exception=>ex
    end
  end


  def add_to_route(routarr, page_url)
    routarr.with_options :url=>page_url do |pers|
      pers.with_options :controller=>index_controller do |cl|
        cl.connect "#{page_url}/:page", :action=>"index", :tab=>nil, :page=>"page-1", :requirements=>{:page=>/page-\d+/}
        cl.connect "#{page_url}/get-form", :action=>"get_form"
        cl.connect "#{page_url}/send_faq", :action=>"send_faq"
      end
    end
  end

  

  def foo; 1 end
end