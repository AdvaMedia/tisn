# To change this template, choose Tools | Templates
# and open the template in the editor.

class Menublock < ActiveRecord::Base


  def menu
    Navigate.find_by_id(menu_id) unless menu_id.blank?
  end
end
