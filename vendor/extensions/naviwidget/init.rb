require 'naviwidget_extension'
NaviwidgetExtension.init_app_paths(%w{ controllers views models helpers})
A2mCms::ExtensionLoader.add_tag_class [NavigationTags]