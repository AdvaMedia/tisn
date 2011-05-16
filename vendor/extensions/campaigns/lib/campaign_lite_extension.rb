class CampaignLiteExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "campaign_lite"
  title "Управление акциями (lite)"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "content"
  visible false
  is_material false
  is_block true
  block_engine CampaignLiteBlockEngine
  #page_engine  PageEngine
  index_controller "CampaignsPublic"

  admin_index "admin/#{extension_group}/campaigns"
  
  define_routes do |map|
  end
  
  def foo; 1 end
end