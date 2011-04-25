# To change this template, choose Tools | Templates
# and open the template in the editor.

class Question < ActiveRecord::Base
  acts_as_list
  
  def vote!
    self.rate = self.rate + 1
    save!
  end
end
