require 'paged_block_extension'
PagedBlockExtension.init_app_paths(%w{ controllers views models helpers})
#classes_with_tags
A2mCms::ExtensionLoader.add_tag_class [PagedBlockTag]