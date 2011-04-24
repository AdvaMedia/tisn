# To change this template, choose Tools | Templates
# and open the template in the editor.

module BlocksTags
  unloadable
  include Taggable

  class TagError < StandardError; end

  [:block_template].each do |prefix|
    [:title, :css_prefix].each do |method|
      tag "#{prefix}:#{method}" do |tag|
        res=tag.locals.block.send(method)
        res.blank? ? "":" #{res}"
      end
    end
  
    tag "#{prefix}:content" do |tag|
      tag.locals.engine.render
    end
    
    tag "#{prefix}:index" do |tag|
      tag.locals.engine.index
    end

  end


end
