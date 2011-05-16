require 'liquid'
class Campaign < ActiveRecord::Base
  belongs_to :map_address
  
  named_scope :avaliabled, :conditions=>["date_on <= :don AND date_off >= :doff", {:don=>Time.now.utc, :doff=>Time.now.utc}]
  
  def ur_address
    ret = []
    [:name, :full_address].each do |sact|
      ret << self.map_address.send(sact).to_s if(self.map_address.respond_to?(sact) && !self.map_address.send(sact).empty?)
    end
    
    ret.join(', ')
  end
end

class CampaignDrop < Clot::BaseDrop
  liquid_attributes << :id << :name << :content << :date_on << :date_off << :map_address << :ur_address
end