# To change this template, choose Tools | Templates
# and open the template in the editor.

class MenuBlockEngine
  include ActionController::UrlWriter
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper

  attr_accessor :block, :tag, :index
  def initialize(blockitem, tagitem, itemindex)
    @block=blockitem
    @tag = tagitem
    @index = itemindex
  end

  def render
    result="Это меню"
    ret = Menublock.find_by_pageblock_id(@block.id)
    result="<a2m:menu id=\"#{ret.menu.id}\" />"
    #result = ret.content unless ret.blank?
    @tag.globals.page.parse(result)
  end

  class << self
    def edit_link_params(blockitem)
      result={}
      block = init_content(blockitem)

      result = {:action=>"select_menu", :controller=>"MenuExt", :id=>block.id}
    end

    def delete(blockitem)
      block = init_content(blockitem)
      block.delete unless block.blank?
    end

    private
    def init_content(blockitem)
      ret=nil
      unless blockitem.blank?
        ret = Menublock.find_by_pageblock_id(blockitem.id)
        ret = Menublock.create(:pageblock_id=>blockitem.id) if ret.blank?
      end
      ret
    end
  end
end
