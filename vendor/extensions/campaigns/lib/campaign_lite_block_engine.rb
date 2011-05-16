require 'liquid'
require 'campaign_liquid_ext'
class CampaignLiteBlockEngine
  attr_accessor :block, :tag, :index
  def initialize(blockitem, tagitem, itemindex)
    @block=blockitem
    @tag = tagitem
    @index = itemindex
  end
  
  def render
    @items = Campaign.avaliabled(:order=>"date_on DESC")
    fname = File.dirname(__FILE__) + "/../app/views/liquid/block_lite.liquid.html"
    @template = File.exist?(fname) ? File.read(fname) : ""
    @page_full_url = "#"
    @pages = Page.all(:conditions=>{:contenttype=>CampaignsExtension.extension_name})
    @page_full_url = @pages.last.full_url unless @pages.blank?
    Liquid::Template.parse(@template).render('campaigns'=>@items.to_a, 'page_url'=>@page_full_url)
  end
  
  class << self
    def edit_link_params(blockitem)
      result="#"
    end
    
    def delete(blockitem)
    end
  end
end