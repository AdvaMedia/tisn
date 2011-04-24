namespace :a2m do
  namespace :extensions do
    namespace :faq do
      desc "migrate extension"
      task :migrate=>:environment do
        if ENV["VERSION"]
          FaqExtension.migrator.migrate(ENV["VERSION"].to_i)
          puts "Start migrate Faq"
        else
          FaqExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install Faq"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:faq:migrate"].execute
        puts "Faq Installed"
      end

      desc "Uninstall Faq"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "Faq UnInstalled"
      end
      
      desc 'Prepare to migrate to another module'
      task :store_to_file => [:environment] do
        puts "Prepare to store data"
        items = Faq.all.to_yaml
        
      end
    end
  end
end