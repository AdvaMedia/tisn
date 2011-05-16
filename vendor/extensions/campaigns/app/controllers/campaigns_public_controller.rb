class CampaignsPublicController < PageController
  layout :get_layout
  before_filter :init_page, :only=>:index
  
  def index
    @items = []
    @items_hash = {}
    Campaign.avaliabled(:order=>"date_on DESC").each do |campaign|
      @items_hash[campaign.map_address.map_region] = [] unless @items_hash.has_key?(campaign.map_address.map_region)
      @items_hash[campaign.map_address.map_region] << campaign
    end
    @items_hash.each_key do |key|
      @items << {"region"=>key, "campaigns"=>@items_hash[key]}
    end
    
    
  end
  
  protected
  def get_layout
    if request.xhr?
      return nil
    end
    unless @page.blank?
      "#{@page.template}/template"
    else
      nil
    end
  end
  
end