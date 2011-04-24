# To change this template, choose Tools | Templates
# and open the template in the editor.

class InterviewVariantsController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @item = Interview.find_by_id(params[:id])
    @tab = "edit"
  end

  def show
    @tab = "edit"
    index
    render :action=>"index"
  end

  def new
    @tab = "edit"
    @item = Interviewvariant.new(:interview_id=>params[:id])
  end

  def create
    new
    if request.post?
      @item.update_attributes(params[:item])
      if @item.save
        redirect_to :action=>"show", :id=>@item.interview.id
      end
    end
  end

  def edit
    @tab = "edit"
    @item = Interviewvariant.find(params[:tid])
  end

  def save
    edit
    if request.post?
      @item.update_attributes(params[:item])
      if @item.save
        redirect_to :action=>"show", :id=>@item.interview.id
      end
    end
  end

  def delete
    edit
    if request.post?
      tmp_id = @item.interview.id
      redirect_to :action=>"show", :id=>tmp_id if @item.delete
    end
  end
end
