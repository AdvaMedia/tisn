# To change this template, choose Tools | Templates
# and open the template in the editor.

class Interviewvariant < ActiveRecord::Base
  belongs_to :interview

  def percent
    result=0
    if self.vote > 0
      result = (self.vote * 100) / self.interview.all_votes 
    end
    result
  end
end
