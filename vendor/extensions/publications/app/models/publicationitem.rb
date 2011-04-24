# To change this template, choose Tools | Templates
# and open the template in the editor.

class Publicationitem < ActiveRecord::Base
  belongs_to :publicationgroup

  before_save :update_tag
  before_create :update_tag

  def update_tag
    self.tag = self.title.dirify if self.tag.blank?
  end
end
