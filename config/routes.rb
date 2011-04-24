ActionController::Routing::Routes.draw do |map|

  # Admin Routes
#  map.with_options(:controller => 'admin/welcome') do |welcome|
#    welcome.admin          'admin',                              :action => 'index'
#    welcome.welcome        'admin/welcome',                      :action => 'index'
#    welcome.login          'admin/login',                        :action => 'login'
#    welcome.logout         'admin/logout',                       :action => 'logout'
#  end
#
#  map.with_options :controller=>'welcome' do |welcome|
#    welcome.welcome   'welcome',                                       :action=>'index'
#    welcome.loguot    'welcome/logout',                                :action=>'logout', :conditions=>{ :method=>:post}
#  end
#
#  map.namespace :admin do |admin|
#    admin.resources :pages
#    admin.resources :templates
#    admin.resources :pageparts
#    admin.resources :part_items
#    admin.resources :htmlblock
#    admin.resources :news
#    admin.resources :htmlrotation
#    admin.resources :orders
#  end

  

  #Заказы
#  map.with_options(:controller => "order_send") do |news|
#    news.getform           '/orders/:id',                       :action=>"get_form"
#    news.sendorder         '/orders/send/:id/',                 :action=>"send_order"
#  end

  #контакты
#  map.with_options(:controller => "contacts") do |news|
#    news.getform           '/contacts',                       :action=>"get_form"
#    news.sendorder         '/contacts/send',                 :action=>"send_contact"
#  end

map.connect ':controller/:action/:id', :controller => /ckeditor.*/
  
  # Site URLs
  map.with_options(:controller => 'site') do |site|
    #site.root                                                    :action => 'show_page', :url => ''
    site.not_found         '*url',                          :action => 'not_found'
    site.error             'error/500',                          :action => 'error'

    # Everything else
    #site.connect           '*url',                               :action => 'show_page'
  end
#  map.connect           '*url',:controller=>"Html",                               :action => 'index'
end
