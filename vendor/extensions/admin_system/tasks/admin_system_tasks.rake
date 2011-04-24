# desc "Explaining what the task does"
# task :admin_system do
#   # Task goes here
# end

namespace :a2m do
  namespace :extensions do
    namespace :admin do
      require 'fileutils'
      @@plugin_self_dir = File.dirname(__FILE__) + '/../'


      desc "Initialize admin system"
      task :migrate=>:environment do
        if ENV["VERSION"]
          AdminExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          AdminExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install Admin System"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:admin:migrate"].execute
        copy_files
        puts "Admin System Installed"
      end

      desc "Uninstall Admin System"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        remove_files
        puts "Admin System UnInstalled"
      end

      private
      def copy_files
        #puts @@plugin_self_dir
        #A2mFileUtils.recursive_copy(:source=>@@plugin_self_dir + '/public', :dest=>RAILS_ROOT + '/public', :log=>true)
      end

      def remove_files
        %w{images javascripts stylesheets}.each do |path_item|
          #FileUtils.rm_r(RAILS_ROOT + '/public/'+path_item+'/adminsystem')
        end
      end
    end
  end
end