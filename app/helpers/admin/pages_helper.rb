module Admin::PagesHelper

  def  bind_page(page)
    ret="<ul  id=\"subnav\"  class=\"box\">"
    ret+=  "<li>"
    ret+=  link_to  page.title,  :controller=>"admin/pages",  :action=>"show",  :id=>page.id
    ret+=bind_subpages(page.children)
    ret+="</li>"
    ret+="</ul>"
  end

  def  bind_subpages(childpages)
    if  childpages
      ret="<ul>"
      childpages.each  do  |page|
        ret+="<li>"
        ret+=link_to  page.title,  :controller=>"admin/pages",  :action=>"show",  :id=>page.id
        ret+=bind_subpages(page.children)
        ret+="</li>"
      end
      ret+="</ul>"
    end
  end
end
