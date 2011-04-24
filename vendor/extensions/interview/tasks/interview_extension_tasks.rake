namespace :a2m do
  namespace :extensions do
    namespace :interview do
      desc "migrate extension"
      task :migrate=>:environment do
        if ENV["VERSION"]
          InterviewExtension.migrator.migrate(ENV["VERSION"].to_i)
          puts "Start migrate Publications"
        else
          InterviewExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install Interview"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:interview:migrate"].execute
        puts "Interview Installed"
      end

      desc "Uninstall Interview"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "Interview UnInstalled"
      end
    end
  end
end