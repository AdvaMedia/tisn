class NavigationExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "navigation"
  title "Управление сайтом"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  #extension_group "Управление сайтом"
  extension_group "content"
  visible true
  admin_index "admin/#{extension_group}/navigation"

  define_routes do |map|
    map.with_options :controller=>"NavigationExt" do |ind_cont|
      ind_cont.connect "/#{admin_index}", :action=>"index"
      ind_cont.connect "/#{admin_index}/addpage", :action => 'add_page'
      ind_cont.connect "/#{admin_index}/create", :action => 'create', :conditions=>{ :method=>:post}
      ind_cont.connect "/#{admin_index}/editpage/:id", :action => 'edit'
      ind_cont.connect "/#{admin_index}/savepage", :action => 'save', :conditions=>{ :method=>:post}
      ind_cont.connect "/#{admin_index}/:id/qdeletepage", :action => 'quest_delete_page'
      ind_cont.connect "/#{admin_index}/:id/deletepage", :action => 'delete_page', :conditions=>{ :method=>:post}
    end
    map.resources :AliasesExt, :path_prefix => admin_index, :collection=>{:predestroy=>:any}

    #Управление шаблонами
    map.connect 'admin/navigation/templates', :controller => 'TemplatesExt', :action => 'index'
    map.connect 'admin/navigation/templates/new', :controller => 'TemplatesExt', :action => 'add_template'
    map.connect 'admin/navigation/templates/create', :controller => 'TemplatesExt', :action => 'create', :conditions=>{ :method=>:post}
    map.connect 'admin/navigation/templates/:id/edit', :controller => 'TemplatesExt', :action => 'edit'
    map.connect 'admin/navigation/templates/:id/save', :controller => 'TemplatesExt', :action => 'save', :conditions=>{ :method=>:post}

    #Управление модулями на странице
    map.connect 'admin/navigation/:id/moduls', :controller => 'ModulsExt', :action => 'show_moduls'
    map.connect 'admin/navigation/:id/:mname/add_modul_in_empty', :controller => 'ModulsExt', :action => 'add_module_in_empty'
    map.connect 'admin/navigation/:mid/add_modul_in_exist', :controller => 'ModulsExt', :action => 'add_module_in_exist'
    map.connect 'admin/navigation/:mid/insert_module', :controller => 'ModulsExt', :action => 'insert_module', :conditions=>{ :method=>:post}
    map.connect 'admin/navigation/:mid/qdelete_module', :controller => 'ModulsExt', :action => 'qdelete_module'
    map.connect 'admin/navigation/:mid/delete_module', :controller => 'ModulsExt', :action => 'delete_module', :conditions=>{ :method=>:post}

    map.namespace :admin do |admin|
      admin.resources :pageparts
      admin.resources :part_items
    end
  end

  def foo; 1 end
end
