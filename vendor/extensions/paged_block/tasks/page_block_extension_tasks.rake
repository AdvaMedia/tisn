namespace :a2m do
  namespace :extensions do
    namespace :paged_block do
      desc "migrate extension"
      task :migrate=>:environment do
        if ENV["VERSION"]
          PagedBlockExtension.migrator.migrate(ENV["VERSION"].to_i)
          puts "Start migrate PageBlock"
        else
          PagedBlockExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install PageBlock"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:paged_block:migrate"].execute
        puts "PageBlock Installed"
      end

      desc "Uninstall PageBlock"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "PageBlock UnInstalled"
      end
    end
  end
end