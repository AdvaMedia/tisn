$KCODE = 'UTF8' unless RUBY_VERSION >= '1.9'
require 'ya2yaml'

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
        items = Faq.all
        p "Fetched #{items.length} faq objects."
        save_path = File.join(RAILS_ROOT, "tmp", "faq_old.yml")
        p "Save faq to #{save_path}"
        File.open(save_path, 'w'){|f| f.write items.ya2yaml(:syck_compatible => true)}
      end
    end
  end
end