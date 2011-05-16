$KCODE = 'UTF8' unless RUBY_VERSION >= '1.9'
require 'ya2yaml'
require "ap"

namespace :a2m do
  namespace :extensions do
    namespace :campaigns do
      desc "migrate extension"
      task :migrate=>:environment do
        if ENV["VERSION"]
          CampaignsExtension.migrator.migrate(ENV["VERSION"].to_i)
          puts "Start migrate Campaigns"
        else
          CampaignsExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install Campaigns"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:campaigns:migrate"].execute
        puts "Campaigns Installed"
      end

      desc "Uninstall Campaigns"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "Campaigns UnInstalled"
      end
    end
  end
end