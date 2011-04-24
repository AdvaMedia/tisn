# To change this template, choose Tools | Templates
# and open the template in the editor.

class PagedBlockExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "paged_block"
  title "Контент с закладками"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  #extension_group "Модули"
  extension_group "content"
  visible true
  is_material true
  is_block true
  block_engine PagedBlockEngine
  page_engine PagedBlockContentEngine
  index_controller "PagedBlock"

  admin_index "admin/#{extension_group}/pagedblocks"

  define_routes do |map|
    begin
      map.with_options :controller=>"PagedBlockGroup" do |ind_cont|
        ind_cont.connect "/#{admin_index}", :action=>"index"
        ind_cont.connect "/#{admin_index}/new", :action=>"new"
        ind_cont.connect "/#{admin_index}/create", :action=>"create"
        ind_cont.connect "/#{admin_index}/:id/edit", :action=>"edit"
        ind_cont.connect "/#{admin_index}/:id/save", :action=>"save"
        ind_cont.connect "/#{admin_index}/:id/delete", :action=>"delete"
      end

      #PagedBlockTabs
      map.with_options :controller=>"PagedBlockTabs" do |ind_cont|
        ind_cont.connect "/#{admin_index}/:id/tabs", :action=>"index"
        ind_cont.connect "/#{admin_index}/:id/new_tab", :action=>"new"
        ind_cont.connect "/#{admin_index}/:id/create_tab", :action=>"create"
        ind_cont.connect "/#{admin_index}/:id/tab/:tid/edit", :action=>"edit"
        ind_cont.connect "/#{admin_index}/:id/tab/:tid/save", :action=>"save"
        ind_cont.connect "/#{admin_index}/:id/tab/:tid/delete", :action=>"delete"
      end

      map.with_options :controller=>"PagedBlockSettings" do |ind_cont|
        ind_cont.connect "/#{admin_index}/for_block/:id", :action=>"for_block"
        ind_cont.connect "/#{admin_index}/for_page/:id", :action=>"for_page"
      end

      map.with_options :controller=>index_controller do |ind_cont|
        ind_cont.connect "/get-content-for/:id/:tag.rjs",:action=>"for_block"
      end

      vopages = Page.all(:conditions=>{:contenttype=>PagedBlockExtension.extension_name})
      init_pages_routes(map)
      rescue Exception=>ex
    end
  end

  def add_to_route(routarr, page_url)
    routarr.with_options :url=>page_url do |pers|
      pers.with_options :controller=>index_controller do |cl|
        cl.connect "#{page_url}/:tab", :action=>"index", :tab=>nil
      end
    end
  end

  def foo; 1 end
end

[Page, Pageblock].map{|item| item.send :include, PagedBlockExtend}