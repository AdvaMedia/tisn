namespace :a2m do
  namespace :extensions do
    namespace :html do
      desc "migrate extension"
      task :migrate=>:environment do
        if ENV["VERSION"]
          HtmlExtension.migrator.migrate(ENV["VERSION"].to_i)
          puts "Start migrate HTML"
        else
          HtmlExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install Html"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:html:migrate"].execute
        puts "Html Installed"
      end

      desc "Uninstall Html"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "Html UnInstalled"
      end
    end
  end
end