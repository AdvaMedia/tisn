# To change this template, choose Tools | Templates
# and open the template in the editor.

class NavigationExtController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    
    respond_to  do  |format|
      format.html  #index.html.erb
    end
  end

  def add_page
    @newpage = Page.new
  end

  #POST
  def create
    @newpage=Page.new
    if request.post?
      @newpage.update_attributes(params[:newpage])
      reload_routes(@newpage)
      redirect_to :action=>"index"
    end
  end

  #get
  def edit
    @selfpage = Page.find(params[:id])
  end

  #post
  def save
    @selfpage = Page.find(params[:id])
    if request.post?
      @selfpage.update_attributes(params[:selfpage])
      reload_routes(@selfpage)
      redirect_to :action=>"index"
    end
  end

  def quest_delete_page
    @selfpage = Page.find(params[:id])
  end

  #post
  def delete_page
    if request.post?
      @selfpage = Page.find(params[:id])
      if @selfpage
        #сюда можно вставить дополнительную очистку...
        #---------------------------------------------
        if @selfpage.destroy
          redirect_to :action=>"index"
        end
      end
    end
  end

  private
  def reload_routes(page)
    #Перезагрузка роутинга
    ActionController::Routing::Routes.reload!
  end
end
