#    admin_campaigns GET    /admin/content/campaigns(.:format)            :action=>"index"}
#                    POST   /admin/content/campaigns(.:format)            :action=>"create"}
# new_admin_campaign GET    /admin/content/campaigns/new(.:format)        :action=>"new"}
#edit_admin_campaign GET    /admin/content/campaigns/:id/edit(.:format)   :action=>"edit"}
#     admin_campaign GET    /admin/content/campaigns/:id(.:format)        :action=>"show"}
#                    PUT    /admin/content/campaigns/:id(.:format)        :action=>"update"}

class CampaignsController < ApplicationController
   layout "admin"
   include AuthenticatedSystem
   before_filter :admin_login_required

   def index
    @items = Campaign.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
   end

   def new
    @campaign = Campaign.new(params[:campaign])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @campaign }
    end
   end

   def create
    @campaign = Campaign.new(params[:campaign])
    respond_to do |format|
      if @campaign.save
        format.html { redirect_to(admin_campaigns_url, :notice => 'Campaign was successfully created.') }
        format.xml  { render :xml => @campaign, :status => :created, :location => @campaign }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @campaign.errors, :status => :unprocessable_entity }
      end
    end
   end

   def show
    edit
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @campaign }
    end
   end

   def edit
    @campaign = Campaign.find_by_id(params[:id])
   end

   def update
    edit
    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        format.html { redirect_to(admin_campaigns_url, :notice => 'Campaign was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @respond_to.errors, :status => :unprocessable_entity }
      end
    end
   end

   def destroy
     edit
     @campaign.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       format.xml  { head :ok }
     end
   end
end