# To change this template, choose Tools | Templates
# and open the template in the editor.

class Publicationitem < ActiveRecord::Base
  belongs_to :publicationgroup

  before_save :update_tag
  before_create :update_tag
  
  #locked and unlocked lists
  {:locked=>true, :unlocked=>false}.each_pair do |key, value|
    named_scope key, :conditions=>{:lock=>value}
  end

  def update_tag
    self.tag = self.title.dirify if self.tag.blank?
  end
  
  def lock_toggle!
    update_attribute(:lock, !self.lock)
  end
  
  def full_url
    self.publicationgroup.blank? ? "#" : [self.publicationgroup.full_url, self.tag].join('/')
  end
end
