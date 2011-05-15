# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'rutils'

class Publicationgroup < ActiveRecord::Base
  has_many :publicationitems, :order=>"created_at DESC", :dependent=>:destroy do
    def locked
      find(:all, :conditions=>["lock = :lock and created_at <= :dt", {:lock=>true, :dt => Time.now}])
    end
    def unlocked
      find(:all, :conditions=>["lock = :lock and created_at <= :dt", {:lock=>false, :dt => Time.now}])
    end
  end
  has_many :publicationpages
  has_many :publicationblocks

  before_save :update_tag
  before_create :update_tag

  def update_tag
    self.tag = self.name.dirify if self.tag.blank?
  end
  
  def full_url
    return "#" if self.publicationpages.count == 0
    self.publicationpages.last.page.blank? ? "#" : self.publicationpages.last.page.full_url
  end
end
