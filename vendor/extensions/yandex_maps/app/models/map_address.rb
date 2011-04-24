class MapAddress < ActiveRecord::Base
  
  belongs_to :map_region, :class_name => "MapRegion", :foreign_key => "map_region_id"
  has_many :office_images, :class_name => "OfficeImage", :order=>"position ASC"
  acts_as_list :scope=>:map_region

  liquid_methods :map_region, :office_images, :country, :name, :federation, :area, :city, :street, :post_index, :house, :office, :work_times, :is_primary, :position, :lat, :lng, :full_address, :phones_ar, :has_phones?, :poster, :has_map?
  
  def full_address
    [:post_index, :federation, :area, :city, :street, :house, :office].
      map{|i| self.send(i).to_s}.
        reject{|i| i.blank?}.join(', ')
  end

  def phones_ar
    self.phones.split('+').collect{|i| rr = i.strip.gsub(/,/,''); rr.empty? ? nil : "+#{rr}"}.compact
  end
  
  def has_map?
    self.lng+self.lat > 0
  end

  def has_phones?
    phones_ar.length > 0
  end

  def poster
    self.office_images.first
  end

  
end
