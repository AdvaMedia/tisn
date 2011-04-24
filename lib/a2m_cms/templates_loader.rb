# To change this template, choose Tools | Templates
# and open the template in the editor.

module A2mCms
  class TemplatesLoader

    attr_accessor :initializer, :templates

    def initialize
      self.templates=[]
    end

    def self.init_templates(dir)
      @templates=Dir.entries(dir)
    end

    def self.loaded_templates
      @templates.reject{|entry| entry==".." or entry=="." or entry==".svn"}
    end

    def self.all_regions(tag_name)
      result=[]
      loaded_templates.each do |templ|
        regions = regions_int_template(templ, tag_name)
        regions.each do |region|
          result << region unless result.select{|reg| reg["name"]==region["name"]}.length>0
        end
      end
      result
    end

    def self.regions_int_template(template_name, tag_name)
      #re = %r{<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)>|</#{tag_prefix}:([\w:]+?)\s*>}
      #re = %r{<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)/>}
      result=[]
      tag_prefix="a2m"
      if sitetemplate(template_name)
        content = File.open(sitetemplate(template_name), 'r') {|f| f.read }
        content.scan(/<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)>|<\/#{tag_prefix}:([\w:]+?)\s*>/i).each do |tag|
          if !result.include?(tag[0]) and tag[0]==tag_name
            result << parse_attributes(tag.at(1))
          end
        end
        content.scan(/<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)\/>/i).each do |tag|
          if !result.include?(tag[0]) and tag[0]==tag_name
            result << parse_attributes(tag.at(1))
          end
        end
      end
      result
    end

    def self.sitetemplate(template_name)
      unless template_name.blank?
        trypath = File.join(RAILS_ROOT,"public","templates","layouts",template_name,"template.erb")
        File.exist?(trypath) ? trypath : nil
      end
    end

    private
    def self.parse_attributes(text) # :nodoc:
      attr = {}
      re = /(\w+?)\s*=\s*('|")(.*?)\2/
      while md = re.match(text)
        attr[$1] = $3
        text = md.post_match
      end
      attr
    end
  end
end
