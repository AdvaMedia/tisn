# Include hook code here
require "navigation_extension"
require "blocks_extension"
NavigationExtension.init_app_paths(%w{ controllers views models helpers})
BlocksExtension.init_app_paths(%w{ controllers views models helpers})