namespace :a2m do
  namespace :extensions do
    namespace :navigation do
      desc "migrate extension"
      task :migrate=>:environment do
        if ENV["VERSION"]
          NavigationExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          NavigationExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install NaviWidget"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:navigation:migrate"].execute
        puts "NaviWidget Installed"
      end

      desc "Uninstall NaviWidget"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "NaviWidget UnInstalled"
      end
    end
  end
end