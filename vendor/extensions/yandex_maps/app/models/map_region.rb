class MapRegion < ActiveRecord::Base
  has_many :map_adresses, :class_name => "MapAddress", :order=>"position ASC"
  acts_as_list

  liquid_methods :id, :map_adresses, :title, :position, :has_addresses?, :tab_name

  def has_addresses?
  	map_adresses > 0
  end
  
  def tab_name
    self.tab || self.title
  end
end
