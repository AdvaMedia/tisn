require 'feedback_extension'
FeedbackExtension.init_app_paths(%w{ controllers views models helpers})
#classes_with_tags
A2mCms::ExtensionLoader.add_tag_class [FeedbackTags]