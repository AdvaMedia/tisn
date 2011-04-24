namespace :a2m do
  namespace :extensions do
    namespace :publications do
      desc "migrate extension"
      task :migrate=>:environment do
        if ENV["VERSION"]
          PublicationsExtension.migrator.migrate(ENV["VERSION"].to_i)
          puts "Start migrate Publications"
        else
          PublicationsExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install Publications"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:publications:migrate"].execute
        puts "Publications Installed"
      end

      desc "Uninstall Publications"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "Publications UnInstalled"
      end
    end
  end
end