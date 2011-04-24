require 'rake'

namespace :a2m do

  desc "Install core site"
  task :install => [:environment, "db:migrate", :create_core_tables, "a2m:extensions:admin:install" ]do
    A2mCms::ExtensionLoader.extensions_to_install.each do |key, value|
      value[1].each do |m|
        m.install
      end
    end
    puts "Install comtleate!"
  end

  desc "Setup core tables"
  task :create_core_tables => :environment do

    #--Создание группы админов
    puts "Ищем администраторов... если их нет, то создаем"
    admins=Role.find_by_name("Admins")
    if not admins
      puts "Группа администраторов не найдена... создаем"
      admins=Role.create(:name=>"Admins", :description=>"Администраторы системы")
      puts "Группа администраторов создана" if admins
    else
      puts "Группа администраторов существует"
    end
    puts "Закончили анализ группы администраторов"
    #---------------------------------------------------------------------------------
    
    # Создание пользователя - администратора системы

    puts "Анализ пользователя - администратора"
    adminuser=User.find_by_login("admin@advamedia.ru")
    if adminuser
      puts "Пользователь существует"
    else
      adminuser=User.new
      adminuser.login = "admin@advamedia.ru"
      adminuser.password = "a2msystem"
      adminuser.password_confirmation = "a2msystem"
      adminuser.save
      puts "Пользователь успешно создан..."
    end

    puts "Проверяем принадлежность пользователя к группе администраторов"
    
    hasrole=false
    adminuser.roles.each do |role|
      hasrole=true if role.name=="Admins"
    end

    if hasrole
      puts "Пользователь уже в группе администраторов"
    else
      if admins.users==nil
        puts "Создаем новый класс"
        admins.users=[adminuser]
      else
        puts "Вставляем в массив"
        admins.users<<adminuser
      end
      admins.save
    end


    #---------------------------------------------------------------------------------
    #Добавление пустого шаблона

#    root_template=Sitetemplate.find_by_name('root_template')
#    if !root_template
#      root_template=Sitetemplate.create(:name=>'root_template', :content=>"")
#    end
    
    #---------------------------------------------------------------------------------

    #Добавление главной страницы

    root_page=Page.first
    if !root_page
      root_page=Page.create(:title=>"Главная страница", :template => "simple-root")
    end
    #child1=Page.create(:title=>"ChildPage1", :template=>root_template, :segment=>"page1", :parent=>root_page)
    #child2=Page.create(:title=>"ChildPage2", :template=>root_template, :segment=>"page2", :parent=>child1)

    #---------------------------------------------------------------------------------

  end

  desc "add_html_modul"
  task :add_html => :environment do
    html=Modul.find_by_tagname("html")
    if !html
      Modul.create(:tagname=>"html", :name=>"html block", :description=>"Вставки HTML кода")
    end
  end

  desc "add_htmlrotate_modul"
  task :add_html_rotation => :environment do
    htmlrotate=Modul.find_by_tagname("htmlrotation")
    if !htmlrotate
      Modul.create(:tagname=>"htmlrotation", :name=>"html rotation", :description=>"Вставки HTML ротации")
    end
  end

  desc "add_orders_modul"
  task :add_orders_modul => :environment do
    orders_mod = Modul.find_by_tagname("ordersform")
    if !orders_mod
      Modul.create(:tagname=>"ordersform", :name=>"orders_online", :description=>"Онлайн регистрация заказов")
    end
  end

#  desc "Добавляем виждеты по-умолчанию"
#  task :create_core_widgets => :environment do
#    Widget.create(:name=>"widget1")
#  end

end