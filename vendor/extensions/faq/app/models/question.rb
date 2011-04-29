# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'thinking_sphinx'
class Question < ActiveRecord::Base
  acts_as_list
  
  define_index do
    indexes title
    indexes content
    indexes answer
    has position
    has rate
    where "answer not null and answer !=''"
  end
  
  def vote!
    self.rate = self.rate + 1
    save!
  end
  
  def timest
    self.created_at.to_i
  end
end
