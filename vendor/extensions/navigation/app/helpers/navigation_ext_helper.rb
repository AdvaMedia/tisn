# To change this template, choose Tools | Templates
# and open the template in the editor.

module NavigationExtHelper
  def  bind_page(page)
    ret="<ul  id=\"subnav\"  class=\"box\">"
    ret+=  "<li>"
    ret+="("
    ret+=link_to  "+",  {:action=>"add_page", :id=>page.id}, :class=>"ajax"
    ret+=link_to  "...",  {:action=>"edit", :id=>page.id}, :class=>"ajax"
    ret+=")"
    ret+=link_to  page.title,  {:action=>"show_moduls",:controller=>"ModulsExt", :id=>page.id}, :class=>"ajax"
    #ret+=link_to  page.title,  {:action=>"add_page", :id=>page.id}, :class=>"ajax"
    ret+=bind_subpages(page.children)
    ret+="</li>"
    ret+="</ul>"
  end

  def  bind_subpages(childpages)
    if  childpages
      ret="<ul>"
      childpages.each  do  |page|
        ret+="<li>"
        ret+="("
        ret+=link_to  "+",  {:action=>"add_page", :id=>page.id}, :class=>"ajax"
        ret+=link_to  "...",  {:action=>"edit", :id=>page.id}, :class=>"ajax"
        ret+=")"
        ret+=link_to  page.title,  {:action=>"show_moduls",:controller=>"ModulsExt", :id=>page.id}, :class=>"ajax"
        #ret+=link_to  page.title,  {:action=>"add_page", :id=>page.id}, :class=>"ajax"
        ret+=bind_subpages(page.children)
        ret+="</li>"
      end
      ret+="</ul>"
    end
  end
end
