# To change this template, choose Tools | Templates
# and open the template in the editor.

module PagedBlockTag
  unloadable
  include Taggable

  class TagError < StandardError; end

  [:tabgroup].each do |prefix|
    tag "#{prefix}" do |tag|
      ret=""
      attr = tag.attr.symbolize_keys
      tag.locals.for_block=attr[:block]
      @tabgroup = Tabgroup.find_by_id(attr[:id])
      tag.locals.tabgroup = @tabgroup
      tag.locals.tab_active_tag = attr[:tag]
      if tag.locals.tab_active_tag.blank?
        activetab_base = @tabgroup.tabitems.select{|t| t.active}.first
        tag.locals.tab_active_tag = activetab_base.tag if activetab_base
      end
      ret = @tabgroup.template unless @tabgroup.blank?
      ret = tag.globals.page.parse(ret)
      ret
    end

    tag "#{prefix}:title" do |tag|
      tag.locals.tabgroup.name if tag.locals.tabgroup
    end

    tag "#{prefix}:content" do |tag|
      result=""
      tab = tag.locals.tabgroup.tabitems.select{|t| t.tag==tag.locals.tab_active_tag}.first
      if tag.locals.for_block
        result +="<div id='group-#{tag.locals.tabgroup.id}' class='tabclass'>"
        result +="#{tab.content if tab}"
        result +="</div>"
      else
        result = tab.content if tab
      end
      result
    end

    [:items].each do |postfix|
      tag "#{prefix}:#{postfix}" do |tag|
        result=[]
        tag.locals.tabgroup.tabitems.each_with_index do |item, i|
          tag.locals.tab_child = item
          tag.locals.tab_item = item
          tag.locals.tab_first_child = i == 0
          tag.locals.tab_last_child = i == tag.locals.tabgroup.tabitems.length - 1
          result << tag.expand
        end
        result
      end

      tag "#{prefix}:#{postfix}:item" do |tag|
        tag.expand unless tag.locals.tab_item.blank?
      end

      tag "#{prefix}:#{postfix}:item:name" do |tag|
        tag.locals.tab_item.name unless tag.locals.tab_item.blank?
      end

      tag "#{prefix}:#{postfix}:item:tag" do |tag|
        url = tag.globals.page.full_url
        url = "#{url}?tab=#{tag.locals.tab_item.tag}" unless tag.locals.tab_item.blank?
        url = url_for(:action=>"for_block",
          :controller=>PagedBlockExtension.index_controller,
          :id=>tag.locals.tab_item.tabgroup.id,
          :tag=>tag.locals.tab_item.tag) if tag.locals.for_block
        url
      end

      tag "#{prefix}:#{postfix}:item:class" do |tag|
        result=[]
        result << "active" if tag.locals.tab_item and tag.locals.tab_item.tag==tag.locals.tab_active_tag
        result << "tabitem_ajax" if tag.locals.for_block
        result.join(" ")
      end

      tag "#{prefix}:#{postfix}:item:image" do |tag|
        tag.locals.tab_item.image_url unless tag.locals.tab_item.blank?
      end
    end

  end
end
