# To change this template, choose Tools | Templates
# and open the template in the editor.

class Sitetemplate < ActiveRecord::Base
  has_many :pages

  include Taggable
  include BaseTags

  attr_accessor :request, :response

  def defined_parts(tagname, tag_prefix="a2m")
    #re = %r{<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)>|</#{tag_prefix}:([\w:]+?)\s*>}
    #re = %r{<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)/>}
    result=[]
    content.scan(/<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)>|<\/#{tag_prefix}:([\w:]+?)\s*>/i).each do |tag|
      if !result.include?(tag[0]) and tag[0]==tagname
        result << tag
      end
    end
    content.scan(/<#{tag_prefix}:([\w:]+?)(\s+(?:\w+\s*=\s*(?:"[^"]*?"|'[^']*?')\s*)*|)\/>/i).each do |tag|
      if !result.include?(tag[0]) and tag[0]==tagname
        result << tag
      end
    end
    result
  end

  def named_parts(noname_parts)
    ret=Hash.new
    if noname_parts.is_a?(Array)
      noname_parts.each do |npart|
        key,value="",""
        match = /^([^=\r\n]+)=(.*)/.match(npart)
        if match
          key = match[0]
          value=match[1]
          ret[key]=value
        end
      end
    end
    ret
  end
end
