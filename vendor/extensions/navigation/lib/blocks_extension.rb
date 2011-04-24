# To change this template, choose Tools | Templates
# and open the template in the editor.

class BlocksExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "blocks"
  title "Блоки"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  #extension_group "Управление сайтом"
  extension_group "content"
  visible true
  admin_index "admin/#{extension_group}/blocks"

  define_routes do |map|
    #PageblocksExt
    map.with_options :controller=>"PageblocksExt" do |ind_cont|
      ind_cont.connect "/#{admin_index}", :action=>"index"
      ind_cont.connect "/#{admin_index}/new", :action=>"new"
      ind_cont.connect "/#{admin_index}/create", :action=>"create"
      ind_cont.connect "/#{admin_index}/edit/:id", :action=>"edit"
      ind_cont.connect "/#{admin_index}/save/:id", :action=>"save"
      ind_cont.connect "/#{admin_index}/delete/:id", :action=>"delete"
    end
  end

  def foo; 1 end
end
