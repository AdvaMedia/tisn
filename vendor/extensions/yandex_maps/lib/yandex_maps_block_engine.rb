require 'liquid'
require 'yandex_helper_liquid.rb'
class YandexMapsBlockEngine
  include FileColumnHelper

  attr_accessor :block, :tag, :index, :template, :template_name
  def initialize(blockitem, tagitem, itemindex)
    @block=blockitem
    @tag = tagitem
    @index = itemindex
    @template_name = "yandex_block"
  end

  def render
    fname = File.dirname(__FILE__) + "/../app/views/liquid/#{@template_name}.html"
    @template = File.exist?(fname) ? File.read(fname) : ""
    
    regions_for_panel = []
    MapRegion.all.each do |region|
      regions_for_panel << {"map_region"=>region, "item"=>region.map_adresses.select{|a| a.is_primary}.first} if region.map_adresses.select{|a| a.is_primary}.count > 0
    end
    
    #regions_for_panel.sort!{|a,b| a["map_region"].position <=> b["map_region"].position}
    
    Liquid::Template.parse(@template).render('yandex_key'=>YandexMapsExtension.yandex_key, 'regions'=>MapRegion.all.select{|i| i.map_adresses.count > 0}, 'primary_offices'=>regions_for_panel)
  end

  class << self
    def edit_link_params(blockitem)
      "#"
    end
  end
end
