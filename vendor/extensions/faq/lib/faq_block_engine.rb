require 'liquid'
class FaqBlockEngine
  attr_accessor :block, :tag, :index, :template, :template_name
  def initialize(blockitem, tagitem, itemindex)
    @block=blockitem
    @tag = tagitem
    @index = itemindex
    @template_name = "faq_block"
  end
  
  def render
    fname = File.dirname(__FILE__) + "/../app/views/liquid/#{@template_name}.html"
    @template = File.exist?(fname) ? File.read(fname) : ""
    
    Liquid::Template.parse(@template).render()
  end
  
  class << self
    def edit_link_params(blockitem)
      "#"
    end
  end
end