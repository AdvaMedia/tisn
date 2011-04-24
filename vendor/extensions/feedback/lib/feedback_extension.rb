class FeedbackExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "feedback"
  title "Обратная связь"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "settings"
  visible true
  is_material false
  is_block false
  block_engine FeedbackBlockEngine
  admin_index "admin/#{extension_group}/feedback"

  define_routes do |map|
    #map.connect 'url', :controller => 'Controller', :action => 'action', :conditions=>{ :method=>:post}
    map.with_options :controller=>"FeedbackAdmin" do |admin|
      admin.connect "/#{admin_index}", :action=>"index"
    end

    map.with_options :controller=>"Feedback" do |fb|
      fb.connect  "/send_feedback.rjs", :action=>"send_feedback"
      fb.connect  "/get_feedback.rjs", :action=>"get_form"
    end
  end

  def foo; 1 end
end