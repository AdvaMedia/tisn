# To change this template, choose Tools | Templates
# and open the template in the editor.

class Publicationblock < ActiveRecord::Base
  belongs_to :publicationgroup
  belongs_to :pageblock
end
