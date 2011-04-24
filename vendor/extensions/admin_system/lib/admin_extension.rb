class AdminExtension < A2mCms::Extension
  
  url "eee"
  extension_name "admin"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "Модули"
  admin_index ""

  define_routes do |map|
    map.connect 'admin', :controller => 'AdminSystem', :action => 'index'
    map.connect 'admin/confirm', :controller => 'AdminSystem', :action => 'confirm'
    map.connect 'admin/logout', :controller => 'AdminSystem', :action => 'logout'
    map.connect 'admin/login', :controller => 'AdminSystem', :action => 'login'
    map.connect 'admin/tags_for/:modul', :controller=>"Admin::TaggbleAdm", :action=>'tags_for'
    map.connect 'admin/:room', :controller=>'AdminSystem', :action=>'show_room'
  end

  def foo; 1 end
end
