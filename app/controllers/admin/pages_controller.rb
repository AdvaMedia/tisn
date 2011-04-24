class Admin::PagesController < AdminController

  # GET
  def index
    @rootpage=Page.find_by_parent_id(nil)
    respond_to  do  |format|
      format.html  #index.html.erb
    end
  end

  # GET
  def show
    @selpage=Page.find(params[:id])
  end

  def new
    @templates_for_page=Sitetemplate.find(:all)
    @parent_page=Page.find(params[:parent_page])
    @newpage=Page.new(:parent=>@parent_page)
    if @parent_page
      respond_to do |format|
        format.html
      end
    else
      render :text=>"Нельзя добавить страницу без родительской..."
    end
  end

  # POST
  def create
    @newpage=Page.new
    if request.post?
      @newpage.update_attributes(params[:newpage])
      redirect_to :action=>"index", :controller=>"admin/pages"
    end
  end

  #GET
  def edit
    @templates_for_page=Sitetemplate.find(:all)
    @selpage=Page.find(params[:id])
  end

  # PUT
  def update
    @selpage=Page.find(params[:id])
    if request.put?
      if @selpage.update_attributes(params[:selpage])
        redirect_to :action=>"index", :controller=>"admin/pages"
      end
    end
  end

  # DELETE
  def destroy
    if request.delete?
      @selpage=Page.find(params[:id])
      if @selpage
        @selpage.destroy
        redirect_to :action=>"index", :controller=>"admin/pages"
      end
    end
  end

end
