# To change this template, choose Tools | Templates
# and open the template in the editor.

class Interview < ActiveRecord::Base
  has_and_belongs_to_many :pageblocks
  has_many :interviewvariants

  def all_votes
    result = 0
    interviewvariants.map{|v| result += v.vote}
    result
  end
end
