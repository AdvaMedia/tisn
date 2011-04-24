# To change this template, choose Tools | Templates
# and open the template in the editor.

class HtmlBlockExtController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @item = HtmlBlock.find_by_id(params[:id])
  end

  def save
    index
    @item.update_attributes(params[:item]) unless @item.blank?
    redirect_to :action=>"index", :controller=>"PageblocksExt"
  end

  def delete
    index
    if request.post?
      #Удаляем!!!
    end
  end


end
