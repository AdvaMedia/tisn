AdminExtension.init_app_paths(%w{ controllers views models})
ActionController::Base.view_paths << "#{RAILS_ROOT}/public/templates"