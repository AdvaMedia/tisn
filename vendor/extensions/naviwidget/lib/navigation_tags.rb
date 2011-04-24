# To change this template, choose Tools | Templates
# and open the template in the editor.

module NavigationTags
  unloadable
  include Taggable

  class TagError < StandardError; end

  
  

  desc %{

  }
  tag 'each_page' do |tag|
    result=[]
    unless tag.globals.navigate.blank?
      pages= tag.locals.menu_page ? tag.locals.menu_page.children : tag.globals.navigate.navinodes
      pages.each_with_index do |item, i|
        tag.locals.menu_child = item
        tag.locals.menu_page = item
        tag.locals.menu_first_child = i == 0
        tag.locals.menu_last_child = i == pages.length - 1
        result << tag.expand
      end
    end
    result
  end

  desc %{
    Если есть дочерние страницы
  }
  tag 'if_childpages' do |tag|
    deb_name=tag.locals.menu_child.id.to_s
    deb_chc=tag.locals.menu_child.children
    tag.expand if deb_chc.length>0
  end

  desc %{
  }
  tag 'if_active' do |tag|
    expand = tag.locals.menu_page.arround_expanded(request.path)
    tag.expand if expand
  end

  desc %{

  }
  tag 'page_link' do |tag|
    linkurl = tag.locals.menu_page.full_url
    page_url = request.path
    "<a #{"class=\"active\"" if page_url.match(/^#{tag.locals.menu_page.full_url}/)} href=#{linkurl}>#{tag.locals.menu_page.name}</a>" unless tag.locals.menu_page.blank?
  end

  tag 'each_page:normal' do |tag|
    linkurl = tag.locals.menu_page.full_url
    page_url= request.path
    is_expanded = tag.locals.menu_page.expanded(page_url)
    is_active = tag.locals.menu_page.active(page_url)
    is_normal= (!is_active and !is_expanded)
    tag.expand if is_normal
  end

  tag 'each_page:active' do |tag|
    #linkurl = tag.locals.menu_page.full_url
    #page_url= request.path
    #tag.expand if request.path.match(/^#{tag.locals.menu_page.full_url}/)
    page_url= request.path
    is_expanded = tag.locals.menu_page.expanded(page_url)
    is_active = tag.locals.menu_page.active(page_url)
    tag.expand if (is_active and is_expanded)
  end

  tag 'each_page:expanded' do |tag|
    page_url= request.path
    exp_url=tag.locals.menu_page.full_url
    is_expanded = tag.locals.menu_page.expanded(page_url)
    is_active = tag.locals.menu_page.active(page_url)
    tag.expand if (!is_active and is_expanded)
  end

  tag 'url' do |tag|
    tag.locals.menu_page.full_url
  end

  tag 'title' do |tag|
    tag.locals.menu_page.name
  end

  tag 'description' do |tag|
    tag.locals.menu_page.page.blank? ? tag.locals.menu_page.name : tag.locals.menu_page.page.title
  end

  #-------------- Новый тэги для нового меню ------------

  
  tag "menu" do |tag|
    ret=""
    attr = tag.attr.symbolize_keys
    root_menu = Navigate.find_by_id(attr[:id])
    if root_menu.enabled
      tag.locals.menu_items = root_menu.navinodes
      template = Menutemplate.find(:first, :conditions=>{:navigate_id=>root_menu.id, :level=>0})
      ret = tag.globals.page.parse(template.template) unless template.blank?
    end
    ret
  end

  [:menuitems].each do |postfix|
    tag "#{postfix}" do |tag|
      result=[]
      unless tag.locals.menu_items.blank?
        pages = tag.locals.menu_items
        pages.reject{|item| !item.enabled}.each_with_index do |item, i|
          tag.locals.menu_child = item
          tag.locals.menu_page = item
          tag.locals.menu_first_child = i == 0
          tag.locals.menu_last_child = i == pages.length - 1
          result << tag.expand
        end
      end
      result
    end

    [:item].each do |mitem|
      tag "#{postfix}:#{mitem}" do |tag|
        tag.expand unless tag.locals.menu_page.blank?
      end

      tag "#{postfix}:#{mitem}:subitems" do |tag|
        ret=""
        tag.locals.menu_items = tag.locals.menu_page.children
        if tag.locals.menu_items.length>0
          template = tag.locals.menu_items.first.menu_template
          ret = tag.globals.page.parse(template.template) unless template.blank?
          #ret=template.template
        end
        ret
      end

      tag "#{postfix}:#{mitem}:active" do |tag|
        page_url= request.path
        is_expanded = tag.locals.menu_page.aexpanded
        is_expanded = tag.locals.menu_page.expanded(page_url) unless is_expanded
        is_active = tag.locals.menu_page.active(page_url)
        tag.locals.menu_items = tag.locals.menu_page.children
        tag.expand if (is_active and is_expanded)
      end

      tag "#{postfix}:#{mitem}:normal" do |tag|
        linkurl = tag.locals.menu_page.full_url
        page_url= request.path
        is_expanded = tag.locals.menu_page.aexpanded
        is_expanded = tag.locals.menu_page.expanded(page_url) unless is_expanded
        is_active = tag.locals.menu_page.active(page_url)
        is_normal= (!is_active and !is_expanded)
        tag.locals.menu_items = tag.locals.menu_page.children
        tag.expand if is_normal
      end

      tag "#{postfix}:#{mitem}:expanded" do |tag|
        page_url= request.path
        exp_url=tag.locals.menu_page.full_url
        is_expanded = tag.locals.menu_page.aexpanded
        is_expanded = tag.locals.menu_page.expanded(page_url) unless is_expanded
        is_active = tag.locals.menu_page.active(page_url)
        tag.locals.menu_items = tag.locals.menu_page.children
        tag.expand if (!is_active and is_expanded)
      end

      tag "#{postfix}:#{mitem}:name" do |tag|
        tag.locals.menu_page.name
      end

      tag "#{postfix}:#{mitem}:url" do |tag|
        ret=tag.locals.menu_page.link_url
        if ret.blank?
          ret=tag.locals.menu_page.page.menu_url
        end
        ret
      end

      tag "#{postfix}:#{mitem}:description" do |tag|
        tag.locals.menu_page.description
      end

    end

  end


  #-------------- /Новый тэги для нового меню ------------
end
