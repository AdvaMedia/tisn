# To change this template, choose Tools | Templates
# and open the template in the editor.

class PagedBlockContentEngine
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
    #ret = Taggroup.find_by_pageblock_id(@block.id)
    result="<a2m:tabgroup id=\"\" />"
  end

  class << self
    def edit_link_params(pageitem)
      result={}
      result = {:action=>"for_page", :controller=>"PagedBlockSettings", :id=>pageitem.id}
    end

    def delete(blockitem)
      #do_nothing
    end

    private
    def init_content(blockitem)
       #do_nothing
    end
  end
end
