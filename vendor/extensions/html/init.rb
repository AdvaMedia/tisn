# Include hook code here
require 'html_extension.rb'
HtmlExtension.init_app_paths(%w{ controllers views models helpers})
A2mCms::ExtensionLoader.add_tag_class [BlocksTags]