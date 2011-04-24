# To change this template, choose Tools | Templates
# and open the template in the editor.

module ModulsExtHelper
 
  def parts_list(page)
    ret=""
    if page.sitetemplate
      ret+="<table><tbody>"
      #named_parts
      partss=page.sitetemplate.defined_parts('container')
      partss.each do |part|
        if part.length>1
          named_part=parse_pairs(part[1])
          if named_part!=""
            ret+="<tr>"
            ret+="<th colspan='2'><h3>#{named_part} "
            spart=nil
            page.page_parts.each do |part|
              spart=part if part.name==named_part
            end
            if !spart
              ret+= link_to("+", {:action=>"add_module_in_empty", :id=>page.id, :mname=>named_part}, {:class=>"ajax"})
            else
              ret+= link_to("+", {:action=>"add_module_in_exist", :mid=>spart.id}, {:class=>"ajax"})
            end
            ret+="</h3></th>"
            ret+="</tr>"
            ret+= get_avalible_moduls(spart)
          end
        end
      end
      ret+="</tbody></table>"
    end
    ret
  end

  private

  def parse_pairs(pair)
    result=""
    regexp = /[Nn][Aa][Mm][Ee]\s*=\s*["'](.*)["']/
    match = regexp.match(pair)
    if match
      result = match[1]
    else
      result = ""
    end
    result
  end

  def get_avalible_moduls(part)
    ret=""
    if part and part.part_items.length>0
        part.part_items.each do |partit|
          ret+="<tr>"
          ret+="<td>"
          ret+= "<h4>#{partit.modul.name} - (#{partit.modul.description})</h4>"
          ret+="</td>"
          ret+="<td>#{link_to("-", {:action=>"qdelete_module", :mid=>partit.id}, {:class=>"ajax"})}</td>"
          ret+="</tr>"
        end
    end
    ret
  end

end
