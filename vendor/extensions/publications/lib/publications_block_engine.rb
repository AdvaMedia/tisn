# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'liquid'
class PublicationsBlockEngine
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
    template = ""
    #@tgroup = @block.tabgroups.first
    #result << "<script type=\"text/javascript\" src=\"/javascripts/#{PagedBlockExtension.extension_name}.js\"></script>"
    ##template = "<a2m:publication_block id=\"#{@block.publicationblocks.first.id}\" />" if @block.publicationblocks.length>0
    #template = @block.publicationblocks.first.template if @block.publicationblocks.length>0
    ##result << @tag.globals.page.parse(template)
    
    template = @block.publicationblocks.first.template
    pubitems = @block.publicationblocks.first.publicationgroup.publicationitems
    Rails.cache.fetch("publication-group-items-#{@block.publicationblocks.first.publicationgroup.id}"){
      Liquid::Template.parse(template).render(
        'lockeds'=>pubitems.locked, 
        'unlockeds'=>pubitems.unlocked, 
        'pub_group'=>@block.publicationblocks.first.publicationgroup,
        'first'=>@block.publicationblocks.first.publicationgroup.publicationitems.first)
    }
    #result.join
  end

  class << self
    def edit_link_params(blockitem)
      result={}
      result = {:action=>"set_to_block", :controller=>"PublicationsGroups", :id=>blockitem.id}
    end
    
    def delete(blockitem)
      p = Publicationblock.find_by_id(blockitem)
      p.delete unless p.blank?
    end
  end
end

class PublicationgroupDrop < Clot::BaseDrop
  liquid_attributes << :publicationitems << :publicationpages << :publicationblocks << :name << :tag << :created_at << :updated_at << :full_url
end

class PublicationitemDrop < Clot::BaseDrop
  liquid_attributes << :publicationgroup << :title << :descriptions << :content << :image_url << :tag << :created_at << :updated_at << :lock << :full_url
end

class PublicationblockDrop < Clot::BaseDrop
  liquid_attributes << :publicationgroup << :pageblock
end

class PublicationpageDrop < Clot::BaseDrop
  liquid_attributes << :page << :publicationgroup
end