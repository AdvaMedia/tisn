namespace :a2m do
  namespace :extensions do
    namespace :yandex_maps do
      desc "migrate extension"
      task :migrate=>:environment do
        if ENV["VERSION"]
          YandexMapsExtension.migrator.migrate(ENV["VERSION"].to_i)
          puts "Start migrate YandexMapsExtension"
        else
          YandexMapsExtension.migrator.migrate
        end
      end

      desc "Prepare To Uninstall YandexMapsExtension"
      task :uninstall_prepare do
        ENV["VERSION"]="0"
      end

      desc "Install YandexMapsExtension"
      task :install=>[:environment] do
        Rake::Task["a2m:extensions:yandex_maps:migrate"].execute
        puts "YandexMapsExtension Installed"
      end

      desc "Uninstall YandexMapsExtension"
      task :uninstall=>[:environment, :uninstall_prepare, :migrate] do
        puts "YandexMapsExtension UnInstalled"
      end
    end
  end
end