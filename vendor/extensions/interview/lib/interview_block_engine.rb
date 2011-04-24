# To change this template, choose Tools | Templates
# and open the template in the editor.

class InterviewBlockEngine
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
    template = ""
    #@tgroup = @block.tabgroups.first
    #result << "<script type=\"text/javascript\" src=\"/javascripts/#{PagedBlockExtension.extension_name}.js\"></script>"
    template = "<a2m:interview_block id=\"#{@block.interviews.first.id}\" />" if @block.interviews.length>0
    #template = @block.publicationblocks.first.template if @block.publicationblocks.length>0
    result << @tag.globals.page.parse(template)
    result.join
  end

  class << self
    def edit_link_params(blockitem)
      result={}
      result = {:action=>"set_to_block", :controller=>"InterviewAdmin", :id=>blockitem.id}
    end
  end
end
