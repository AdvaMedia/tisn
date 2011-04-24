# To change this template, choose Tools | Templates
# and open the template in the editor.

class Navigate < ActiveRecord::Base
  has_many :navinodes, :order=>"order_num", :conditions =>{:parent_id=>nil}
  has_many :menutemplates

  def all_navinodes(selfnode)
    ret=[]
    navinodes.reject{|node| node==selfnode}.each do |node|
      ret<<node
      ret<<get_child_nodes(node.children, selfnode)
    end
    ret.flatten
  end

  private
  def get_child_nodes(nodes, selfnode)
    ret=[]
    nodes.reject{|node| node==selfnode}.each do |node|
      ret<<node
      ret<<get_child_nodes(node.children, selfnode)
    end
    ret
  end
end
