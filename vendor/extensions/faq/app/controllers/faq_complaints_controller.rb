#    admin_faq_complaints GET    /admin/content/faq/complaints(.:format)                   {:controller=>"faq_complaints", :action=>"index"}
#                         POST   /admin/content/faq/complaints(.:format)                   {:controller=>"faq_complaints", :action=>"create"}
# new_admin_faq_complaint GET    /admin/content/faq/complaints/new(.:format)               {:controller=>"faq_complaints", :action=>"new"}
#edit_admin_faq_complaint GET    /admin/content/faq/complaints/:id/edit(.:format)          {:controller=>"faq_complaints", :action=>"edit"}
#     admin_faq_complaint GET    /admin/content/faq/complaints/:id(.:format)               {:controller=>"faq_complaints", :action=>"show"}
#                         PUT    /admin/content/faq/complaints/:id(.:format)               {:controller=>"faq_complaints", :action=>"update"}
#                         DELETE /admin/content/faq/complaints/:id(.:format)               {:controller=>"faq_complaints", :action=>"destroy"}
class FaqComplaintsController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required
  
  
  def index
    @items = Complaint.all(:order=>"created_at DESC")
  end
  
  def show
    edit
  end
  
  def edit
    @item = Complaint.find_by_id(params[:id])
  end
  
  def destroy
     edit
     @item.destroy
     respond_to do |format|
       format.html { redirect_to :back }
       format.xml  { head :ok }
     end
   end
end