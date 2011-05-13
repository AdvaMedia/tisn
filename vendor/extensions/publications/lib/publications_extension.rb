class PublicationsExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "publications"
  title "Публикации"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  #extension_group "Модули"
  extension_group "content"
  visible true
  is_material true
  is_block true
  block_engine PublicationsBlockEngine
  page_engine PublicationPageEngine
  index_controller "Publications"

  admin_index "admin/#{extension_group}/publications"

  define_routes do |map|
    #map.connect 'url', :controller => 'Controller', :action => 'action', :conditions=>{ :method=>:post}
    begin
      map.with_options :controller=>"PublicationsGroups" do |ind_cont|
        ind_cont.connect "/#{admin_index}", :action=>"index"
        ind_cont.connect "/#{admin_index}/new", :action=>"new"
        ind_cont.connect "/#{admin_index}/create", :action=>"create"
        ind_cont.connect "/#{admin_index}/:id/edit", :action=>"edit"
        ind_cont.connect "/#{admin_index}/:id/save", :action=>"save"
        ind_cont.connect "/#{admin_index}/:id/delete", :action=>"delete"
      end

      map.with_options :controller=>"PublicationsItems" do |ind_cont|
        ind_cont.connect "/#{admin_index}/items", :action=>"index"
        ind_cont.connect "/#{admin_index}/:id/items", :action=>"show"
        ind_cont.connect "/#{admin_index}/:id/new_item", :action=>"new"
        ind_cont.connect "/#{admin_index}/:id/create_item", :action=>"create"
        ind_cont.connect "/#{admin_index}/:id/item/:tid/edit", :action=>"edit"
        ind_cont.connect "/#{admin_index}/:id/item/:tid/save", :action=>"save"
        ind_cont.connect "/#{admin_index}/:id/item/:tid/delete", :action=>"delete"
        ind_cont.connect "/#{admin_index}/:id/item/:tid/togle", :action=>"toggle_lock"
      end

      map.with_options :controller=>"PublicationsGroups" do |ind_cont|
        ind_cont.connect "/#{admin_index}/for_block/:id", :action=>"set_to_block"
        ind_cont.connect "/#{admin_index}/for_page/:id", :action=>"set_to_page"
      end


      vopages = Page.all(:conditions=>{:contenttype=>PublicationsExtension.extension_name})
      init_pages_routes(map)
      rescue Exception=>ex
    end
  end

   def add_to_route(routarr, page_url)
    routarr.with_options :url=>page_url do |pers|
      pers.with_options :controller=>index_controller do |cl|
        cl.connect "#{page_url}.:format", :action=>"index", :tab=>nil, :page=>"page-1"
        cl.connect "#{page_url}/:page", :action=>"index", :tab=>nil, :requirements=>{:page=>/page-\d+/}
        cl.connect "#{page_url}/:tab", :action=>"index", :page=>"page-1"
      end
    end
  end

  def foo; 1 end
end

Page.send :include, PublicationPageExtend
Pageblock.send :include, PublicationPageblockExtend