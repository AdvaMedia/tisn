# To change this template, choose Tools | Templates
# and open the template in the editor.

class Interviewblock < ActiveRecord::Base
  belongs_to :pageblock
  belongs_to :interview
end
