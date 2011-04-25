class FaqExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "faq"
  title "Вопросы и ответы"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "content"
  visible true
  is_material false
  is_block true
  block_engine FaqBlockEngine
  #page_engine  FaqPageEngine
  index_controller "Faq"

  admin_index "admin/#{extension_group}/faq"

  define_routes do |map|
    map.with_options( 
      :name_prefix => "admin_",
      :path_prefix => "admin/#{extension_group}",
      :requirements => {:id => /[0-9]+/}
    ) do |admin|
      admin.resources :faq_admin, :as=>"faq"
    end
    map.with_options( 
      :name_prefix => "admin_",
      :path_prefix => "admin/#{extension_group}/faq",
      :requirements => {:id => /[0-9]+/}
    ) do |admin|
      admin.resources :faq_questions, :as=>"questions",:member => { 
        :move_to => :get,
        :toggle_vip => :get
      }
    end
  end  

  def foo; 1 end
end