require 'liquid'
class Campaign < ActiveRecord::Base
  belongs_to :map_address
  
  named_scope :avaliabled, :conditions=>["date_on <= :don AND date_off >= :doff", {:don=>Time.now.utc, :doff=>Time.now.utc}]
end

class CampaignDrop < Clot::BaseDrop
  liquid_attributes << :id << :name << :content << :date_on << :date_off << :map_address
end