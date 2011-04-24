require 'interview_extension'
InterviewExtension.init_app_paths(%w{controllers views models helpers})
#classes_with_tags
A2mCms::ExtensionLoader.add_tag_class [InterviewTagsList]