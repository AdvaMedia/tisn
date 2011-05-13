# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'rutils'

class Publicationgroup < ActiveRecord::Base
  has_many :publicationitems, :order=>"created_at DESC", :dependent=>:destroy do
    def locked
      find(:all, :conditions=>{:lock=>true})
    end
    def unlocked
      find(:all, :conditions=>{:lock=>false})
    end
  end
  has_many :publicationpages
  has_many :publicationblocks

  before_save :update_tag
  before_create :update_tag

  def update_tag
    self.tag = self.name.dirify if self.tag.blank?
  end
end
