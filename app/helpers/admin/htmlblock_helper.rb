module Admin::HtmlblockHelper

  def  bind_pagehtml(page)
    ret= "<ul  id=\"subnav\"  class=\"box\">"
    ret+= "<li>"
    ret+= link_to  page.title,  :controller=>"admin/htmlblock",  :action=>"show",  :id=>page.id
    ret+= bind_subpageshtml(page.children)
    ret+= "</li>"
    ret+= "</ul>"
  end

  def  bind_subpageshtml(childpages)
    if  childpages
      ret= "<ul>"
      childpages.each  do  |page|
        ret+= "<li>"
        ret+= link_to  page.title,  :controller=>"admin/htmlblock",  :action=>"show",  :id=>page.id
        ret+= bind_subpageshtml(page.children)
        ret+= "</li>"
      end
      ret+= "</ul>"
    end
  end

  def html_description(part)
    html_mod=HtmlBlock.find_by_part_item_id(part.id)
    if html_mod and !html_mod.description.blank?
      html_mod.description
    else
      "Не заполнено"
    end
  end

  def html_content(part)
    html_mod=HtmlBlock.find_by_part_item_id(part.id)
    if html_mod and !html_mod.content.blank?
      html_mod.content[0..200]
    else
      ""
    end
  end

  def link_to_html(part)
    html_mod=HtmlBlock.find_by_part_item_id(part.id)
    if html_mod
      link_to "Редактировать", {:action=>"edit", :controller=>"admin/htmlblock", :id=>html_mod.id}
    else
      link_to "Редактировать", {:action=>"new", :controller=>"admin/htmlblock", :part_id=>part.id}
    end
  end
end
