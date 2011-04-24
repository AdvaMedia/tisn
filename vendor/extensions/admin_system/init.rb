# Include hook code here
require 'admin_system'
require 'admin_extension.rb'

require 'settings_extension'
#SettingsExtension.init_app_paths(%w{controllers views models helpers})
#classes_with_tags
A2mCms::ExtensionLoader.add_tag_class []