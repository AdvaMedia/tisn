# To change this template, choose Tools | Templates
# and open the template in the editor.

class HtmlBlockEngine
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
    result=""
    ret = HtmlBlock.find_by_pageblock_id(@block.id)
    result = ret.content unless ret.blank?
    @tag.globals.page.parse(result)
  end

  class << self
    def edit_link_params(blockitem)
      result={}
      block = init_content(blockitem)

      result = {:action=>"index", :controller=>"HtmlBlockExt", :id=>block.id}
    end

    def delete(blockitem)
      block = init_content(blockitem)
      block.delete unless block.blank?
    end

    private
    def init_content(blockitem)
      ret=nil
      unless blockitem.blank?
        ret = HtmlBlock.find_by_pageblock_id(blockitem.id)
        ret = HtmlBlock.create(:pageblock_id=>blockitem.id, :content=>"") if ret.blank?
      end
      ret
    end
  end
end
