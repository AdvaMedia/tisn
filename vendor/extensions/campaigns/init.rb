require 'campaigns_extension'
CampaignsExtension.init_app_paths(%w{controllers views models helpers})
#classes_with_tags
A2mCms::ExtensionLoader.add_tag_class []