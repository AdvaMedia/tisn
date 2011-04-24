# To change this template, choose Tools | Templates
# and open the template in the editor.

module NavWidNodesAdminHelper
  def nav_breadcrumbs(nodeitem)
    ret=""
    node_items=[]
    unless nodeitem.blank?
      while !nodeitem.blank?
        node_items << nodeitem
        nodeitem=nodeitem.parent
      end
    end
    count=node_items.length
    unless count==0
      ret+="<ul class=\"breadcrumbs\">"
      node_items.reverse.each_with_index do |node, index|
        if node.children.length>0
          href = url_for(:action=>"index_child", :parentid=>node.id)
          ret+="<li><a href=\"#{href}\" class=\"ajax\">#{node.name}</a></li>"
        else
          ret+="<li><span>#{node.name}</span></li>"
        end
      end
      ret+="</ul>"
    end
    ret
  end

  def render_navinodes(nodes)
    ret=""
    if nodes.length>0
      ret+="<ul>"
      nodes.each do |node|
        self_link = link_to(node.name, {:action=>"edit", :id=>node.id}, {:class=>"ajax"})
        add_link = link_to("+", {:action=>"new", :id=>node.get_navigate.id, :parent=>node.id}, {:class=>"ajax"})
        del_link = link_to("-", {:action=>"destroy", :id=>node.id}, {:class=>"ajax"})
        ret+=<<EOF
        <li>
          #{self_link}
          (#{add_link}, #{del_link})
          #{render_navinodes node.children}
        </li>
EOF
      end
      ret+="</ul>"
    end
    ret
  end
end
