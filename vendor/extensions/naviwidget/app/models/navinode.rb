# To change this template, choose Tools | Templates
# and open the template in the editor.

class Navinode < ActiveRecord::Base
  acts_as_tree :order => "order_num"
  belongs_to :navigate
  belongs_to :page

  def get_navigate
    navigate.blank? ? parent.get_navigate : navigate
  end

  def full_url
    if link_url.blank?
      unless page_id.blank?
        spage=Page.find_by_id(page_id)
        spage.blank? ? "#" : spage.menu_url
      else
        "#"
      end
    else
      link_url
    end
  end

  def depth
    parent.blank? ? 0 : parent.depth+1
  end

  def name_for_select
    ret=""
    depth.times {ret+="-"}
    ret+=" #{name}"
  end

  def active(url)
    t_full=full_url
    if (full_url=='/' and url!='/')
      return false
    end
    if url.match(/^#{full_url}\/*/)!=nil
      return true
    end
    return false
  end

  def expanded(url)
    child_active(url)
  end

  def child_active(url)
    ret=active(url)
    unless ret
    child_count=children.select{|child_item| child_item.expanded(url)}
    ret=child_count.length>0
    end
    ret
  end

  def class_for_admin
    ret=""
    ret+="link-folder" if children.count>0
    ret
  end

  def menu_template
    ret=Menutemplate.find(:first, :conditions=>{:navigate_id=>navigate.id, :level=>depth})
    ret=parent.menu_template if ret.blank?
    ret
  end
end
