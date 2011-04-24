# To change this template, choose Tools | Templates
# and open the template in the editor.

class Page < ActiveRecord::Base
  include WillPaginate::ViewHelpers
  has_and_belongs_to_many :pageblocks
  has_many :pagealiases

  before_save :recreate_url
  before_update :recreate_url
  after_save    :reinit_blocks

  attr_accessor :request, :response, :locals, :current_user, :global_config

  include Taggable
  include BaseTags

  def content_name
    ret="ошибка"
    ass_exts = A2mCms::ExtensionLoader.extensions.select{|cont| cont.extension_name==contenttype}
    unless ass_exts.length==0
      ret=ass_exts.first.title
    end
    ret
  end

  def engine
    ext="#{contenttype.split('_').map{|name| name.capitalize}.join}Extension".constantize.page_engine
  end

  def page
    self
  end

  def pre_process(request, response)
    @global_config = SiteGlobalSettings.new
    @request, @response = request, response
    
    @response.body = response.body.to_s
    @response.status = response_code
  end

  def response_code
    200
  end

  def menu_url
    "#{full_url}"
  end

  def self_page_name
    result = title
    unless full_url=="/" and @global_config.name
      result = "#{title} / #{@global_config.name.to_s}"
    end
    result
  end
  
  def lazy_initialize_parser_and_context
    unless @parser and @context
      A2mCms::ExtensionLoader.tags_classes.each do |tagclass|
        class_eval {include tagclass}
      end
      @context = TagsContent.new(self)
      @parser = Radius::Parser.new(@context, :tag_prefix => 'a2m')
    end
    @parser
  end

  def parse(text)
    lazy_initialize_parser_and_context.parse(text)
  end

  def parse_object(object)
    unless object.blank?
      text = File.open(object){ |file| file.read }
      text = parse(text)
    end
  end

  def sitetemplate
    unless template.blank?
      trypath = File.join(RAILS_ROOT,"public","templates","layouts",template,"template.erb")
      File.exist?(trypath) ? trypath : nil
    end
  end

  def self.parce_url(url)
    if Array === url
      url = url.join('/')
    else
      url = url.to_s
    end
  end

  def defined_regions(tagname, tag_prefix="a2m")
    #re = %r{<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)>|</#{tag_prefix}:([\w:]+?)\s*>}
    #re = %r{<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)/>}
    result=[]
    if sitetemplate
      content = File.open(sitetemplate, 'r') {|f| f.read }
      content.scan(/<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)>|<\/#{tag_prefix}:([\w:]+?)\s*>/i).each do |tag|
        if !result.include?(tag[0]) and tag[0]==tagname
          result << parse_attributes(tag.at(1))
        end
      end
      content.scan(/<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)\/>/i).each do |tag|
        if !result.include?(tag[0]) and tag[0]==tagname
          result << parse_attributes(tag.at(1))
        end
      end
    end
    result
  end

  def regions
    defined_regions("region")
  end


  def self.extract_by(url)
    ret=find_by_full_url(url)
    if ret.blank?
      #пробуем найти в алиасах
      aliases_for_page = Pagealias.find_all_by_url(url)
      unless aliases_for_page.blank?
        ret=aliases_for_page[0].page
      end
    end
    return ret
  end

  def flash
    response.template.controller.self_flash
  end

  private
  def parse_attributes(text) # :nodoc:
    attr = {}
    re = /(\w+?)\s*=\s*('|")(.*?)\2/
    while md = re.match(text)
      attr[$1] = $3
      text = md.post_match
    end
    attr
  end

  def recreate_url
    self.full_url="/#{self.segment}"
  end

  def reinit_blocks
    Pageblock.all.map{|block| block.save}
  end

end
