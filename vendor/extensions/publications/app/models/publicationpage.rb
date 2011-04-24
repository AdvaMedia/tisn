# To change this template, choose Tools | Templates
# and open the template in the editor.

class Publicationpage < ActiveRecord::Base
  belongs_to :publicationgroup
  belongs_to :page
end
