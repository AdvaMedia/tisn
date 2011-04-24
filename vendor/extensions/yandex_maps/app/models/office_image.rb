class OfficeImage < ActiveRecord::Base
  include FileColumnHelper
  belongs_to :map_address, :class_name => "MapAddress", :foreign_key => "map_address_id"
  acts_as_list :scope=>:map_address

  file_column :image, :magick => { 
        :image_required => false,
        :versions => {
          :thumb => "120x80",
          :orig => {:name=>"orig"},
          :widescreen => {:crop => "12:8", :size => "120x80!"}
          }
      }

  #liquid_methods :position, :image, :alt_text, :map_address, :image_url

  def image_url(ver)
    url_for_file_column(self, "image", ver)
  end

  def to_liquid
    self
  end
end
