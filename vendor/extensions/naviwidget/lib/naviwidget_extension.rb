class NaviwidgetExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "naviwidget"
  title "Меню"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  #extension_group "Виджеты"
  extension_group "content"
  visible true
  admin_index "admin/#{extension_group}/navigate"

  is_block true
  block_engine MenuBlockEngine
  index_controller "MenuExt"

  define_routes do |map|

    map.with_options :controller=>"MenuExt" do |ind_cont|
      ind_cont.connect "/#{admin_index}", :action=>"index"
      ind_cont.connect "/#{admin_index}/show/:id", :action=>"show"
      ind_cont.connect "/#{admin_index}/new", :action=>"new"
      ind_cont.connect "/#{admin_index}/create", :action=>"create"
      ind_cont.connect "/#{admin_index}/:id/edit", :action=>"edit"
      ind_cont.connect "/#{admin_index}/:id/save", :action=>"save"
      ind_cont.connect "/#{admin_index}/:id/delete", :action=>"delete"

      ind_cont.connect "/#{admin_index}/select_menu/:id", :action=>"select_menu"

      ind_cont.connect "/#{admin_index}/:id/new_node", :action=>"new_node"
      ind_cont.connect "/#{admin_index}/:id/create_node", :action=>"create_node"
      ind_cont.connect "/#{admin_index}/:id/edit_node/:tid", :action=>"edit_node"
      ind_cont.connect "/#{admin_index}/:id/save_node/:tid", :action=>"save_node"
      ind_cont.connect "/#{admin_index}/:id/delete_node/:tid", :action=>"delete_node"
      ind_cont.connect "/#{admin_index}/:id/toggle_node/:tid", :action=>"toggle_node"
      ind_cont.connect "/#{admin_index}/:id/toggle_node_visible/:tid", :action=>"toggle_node_visible"

    end

    #MenuTempate
    map.with_options :controller=>"MenuTempate" do |ind_cont|
      #управление шаблонами рендеринга меню
      ind_cont.connect "/#{admin_index}/:id/templates", :action=>"index"
      ind_cont.connect "/#{admin_index}/:id/templates/new", :action=>"new"
      ind_cont.connect "/#{admin_index}/:id/templates/create", :action=>"create"
      ind_cont.connect "/#{admin_index}/:id/templates/:tid/edit", :action=>"edit"
      ind_cont.connect "/#{admin_index}/:id/templates/:tid/save", :action=>"save"
      ind_cont.connect "/#{admin_index}/:id/templates/:tid/delete", :action=>"delete"
    end

    #map.connect 'url', :controller => 'Controller', :action => 'action', :conditions=>{ :method=>:post}

    #map.connect 'admin/naviwidget', :controller => 'NavividgetAdmin', :action => 'index'
    #map.connect 'admin/newnav', :controller => 'NavividgetAdmin', :action => 'newnav'
    #map.connect 'admin/editnav/:id', :controller => 'NavividgetAdmin', :action => 'editnav'

    #map.connect 'admin/editnodes/:id', :controller => 'NavWidNodesAdmin', :action => 'index'
    #map.connect 'admin/editnodes/:id/new', :controller => 'NavWidNodesAdmin', :action => 'new'
    #map.connect 'admin/editnodes/:id/create', :controller => 'NavWidNodesAdmin', :action => 'save'
    #map.connect 'admin/editnodes/:id/edit', :controller => 'NavWidNodesAdmin', :action => 'edit'
    #map.connect 'admin/editnodes/:id/update', :controller => 'NavWidNodesAdmin', :action => 'update'
    #map.connect 'admin/editnodes/:id/destroy', :controller => 'NavWidNodesAdmin', :action => 'destroy'

  end

  def foo; 1 end
end

