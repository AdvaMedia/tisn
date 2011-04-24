# To change this template, choose Tools | Templates
# and open the template in the editor.

module MenuExtHelper

  def build_nodes(parent_elements)
    elements=[]
    parent_elements.each do |element|
      elements << element
      elements << build_nodes(elements.children) unless element.children.count==0
    end
    elements
  end
end
