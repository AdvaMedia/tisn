module Admin::PagepartsHelper

  def  bind_pagetree(page)
    ret="<ul  id=\"subnav\"  class=\"box\">"
    ret+=  "<li>"
    ret+=  link_to  page.title,  {:controller=>"admin/pageparts",  :action=>"show",  :id=>page.id}, {:class=>'ajax'}
    ret+=bind_subpagestree(page.children)
    ret+="</li>"
    ret+="</ul>"
  end

  def  bind_subpagestree(childpages)
    if  childpages
      ret="<ul>"
      childpages.each  do  |page|
        ret+="<li>"
        ret+=link_to page.title,  {:controller=>"admin/pageparts",  :action=>"show",  :id=>page.id}, {:class=>'ajax'}
        ret+=bind_subpagestree(page.children)
        ret+="</li>"
      end
      ret+="</ul>"
    end
  end

  def parts_list(page)
    ret=""
    if page
      ret+="<ul>"
      #named_parts
      partss=page.defined_parts('container')
      partss.each do |part|
        if part.length>1
          named_part=parse_pairs(part[1])
          if named_part!=""
            ret+="<li>#{named_part} (#{link_to("Редактировать", {:action=>"edit", :controller=>"admin/pageparts", :named_part=>named_part}, {:class=>'ajax'})})</li>"
          end
        end
      end
      ret+="</ul>"
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
end
