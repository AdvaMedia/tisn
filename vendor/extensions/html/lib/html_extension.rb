class HtmlExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "html"
  title "Без контента"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  #extension_group "Модули"
  extension_group "content"
  visible false
  is_material true
  is_block true
  block_engine HtmlBlockEngine
  index_controller "EmptyPage"

  admin_index "admin/#{extension_group}/htmlblocks"

  define_routes do |map|
    begin
      map.with_options :controller=>"HtmlBlockExt" do |ind_cont|
        ind_cont.connect "/#{admin_index}/:id", :action=>"index"
        ind_cont.connect "/#{admin_index}/:id/save", :action=>"save"
        ind_cont.connect "/#{admin_index}/:id/delete", :action=>"delete"
      end
      vopages = Page.all(:conditions=>{:contenttype=>HtmlExtension.extension_name})
      init_pages_routes(map)
      rescue Exception=>ex
    end
  end

  def add_to_route(routarr, page_url)
    routarr.with_options :url=>page_url do |pers|
      pers.with_options :controller=>index_controller do |cl|
        cl.connect "#{page_url}", :action=>"index"
      end
    end
  end

  def foo; 1 end
end
