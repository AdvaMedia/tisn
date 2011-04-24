# To change this template, choose Tools | Templates
# and open the template in the editor.

class PagedBlockEngine
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
    result=[]
    @tgroup = @block.tabgroups.first
    result << "<script type=\"text/javascript\" src=\"/javascripts/#{PagedBlockExtension.extension_name}.js\"></script>"
    template = "<a2m:tabgroup id=\"#{@tgroup.id}\" block=\"true\" />" unless @tgroup.blank?
    result << @tag.globals.page.parse(template)
    result.join
  end

  class << self
    def edit_link_params(blockitem)
      result={}
      result = {:action=>"for_block", :controller=>"PagedBlockSettings", :id=>blockitem.id}
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
