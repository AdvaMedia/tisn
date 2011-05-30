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
      
      desc 'import old data'
      task :import => [:environment] do
        puts "Prepare to import data"
        save_path = File.join(RAILS_ROOT, "tmp", "faq_old.yml")
        items = []
        items = YAML.load(File.read(save_path)) if File.exist?(save_path)
        unless items.blank?
          p "Loaded #{items.length} items"
          items.each do |question|
            attrbts = question.ivars["attributes"]
            Question.create(:title=>attrbts["querytitle"], :content=>attrbts["query"], :name=>attrbts["querist"], :answer=>attrbts["answer"])
          end
        end
      end
    end
  end
end


namespace :faq do
  desc 'Sena mail with questions and complaints'
  task :send_mail=>[:environment] do
    #sent_body={"current_date"=>Time.now, "company"=>"Окна ТиСН", "site"=>{"name"=>"Окна ТиСН"}}
    @items = {}    
    @items["questions"] = Question.all(:conditions=>{:mailme=>false})
    @items["complaints"] = Complaint.all(:conditions=>{:mailme=>false})
    @items["current_date"] = Time.now
    @items["company"]="Окна ТиСН"
    @items["site"]={"name"=>"Окна ТиСН"}
    begin
      p "Sending mail to #{A2mConfiguration.get_value(FeedbackExtension.extension_name, "mail", "postmaster@advamedia.ru")}"
      FaqMailer.deliver_faq_messages('tisn@advamedia.ru', A2mConfiguration.get_value(FeedbackExtension.extension_name, "mail", "postmaster@advamedia.ru"), "Информация о поступивших вопросах и претензиях (не требует ответа)", @items, Time.now)
      ([] << @items["questions"] << @items["complaints"]).flatten.each do |itm|
        unless itm.blank?
          itm.mailme = true
          itm.save!
        end
      end
    rescue Exception => e
      p "!!!!!!!!!!!!!!!!!"
      p e
    end
  end
end