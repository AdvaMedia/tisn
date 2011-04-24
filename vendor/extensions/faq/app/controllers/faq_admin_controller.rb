# To change this template, choose Tools | Templates
# and open the template in the editor.

class FaqAdminController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @page_num = params[:page] || 1
    @items = Faq.all(:order=>"created_at DESC").paginate(:per_page=>20, :page=>@page_num.to_i)
  end

  def set_to_page
    
  end

  def edit
    @item = Faq.find_by_id(params[:id])
  end

  def save
    edit
    if request.post?
      @item.update_attributes(params[:item])
      redirect_to :action=>"index"
    end
  end
end
