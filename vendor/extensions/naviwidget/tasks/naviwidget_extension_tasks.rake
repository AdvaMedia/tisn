# desc "Explaining what the task does"
# task :naviwidget_extension do
#   # Task goes here
# end
require 'rake'
namespace :a2m do
  namespace :extensions do
    namespace :naviwidget do
      desc "migrate extension"
      task :migrate=>:environment do
        puts "Действия с базами данных навигации"
        if ENV["VERSION"]
          NaviwidgetExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          NaviwidgetExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install NaviWidget"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:naviwidget:migrate"].execute
        puts "NaviWidget Installed"
      end

      desc "Uninstall NaviWidget"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "NaviWidget UnInstalled"
      end
    end
  end
end