namespace :a2m do
  namespace :extensions do
    namespace :feedback do
      desc "migrate extension"
      task :migrate=>:environment do
        if ENV["VERSION"]
          FeedbackExtension.migrator.migrate(ENV["VERSION"].to_i)
          puts "Start migrate Feedback"
        else
          FeedbackExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install Feedback"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:feedback:migrate"].execute
        puts "Feedback Installed"
      end

      desc "Uninstall Feedback"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "Feedback UnInstalled"
      end
    end
  end
end