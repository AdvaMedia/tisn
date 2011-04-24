# To change this template, choose Tools | Templates
# and open the template in the editor.

class SettingsExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "settings"
  title "Настройка сайта"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "settings"
  visible true
  is_material false
  is_block false
  admin_index "admin/#{extension_group}/global"

  define_routes do |map|
    begin
      map.with_options :controller=>"GlobalSettings" do |ind_cont|
        ind_cont.connect "/#{admin_index}", :action=>"index"
      end

    rescue Exception=>ex
    end
  end

  def foo; 1 end
end
