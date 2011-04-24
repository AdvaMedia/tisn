class Admin::TemplatesController < AdminController

  # GET - displays all
  def index
    @templates=Sitetemplate.find(:all)
    respond_to do |format|
      format.html
    end
  end


  def new
    @templ=Template.new
  end

  # POST - creates a new
  def create
    if request.post?
      new
      @templ.update_attributes(params[:templ])
      redirect_to :action=>"index", :controller=>"admin/templates"
    end
  end

  # GET - shows one (based on the supplied id)
  def show
  end

  #GET
  def edit
    @templ=Sitetemplate.find(params[:id])
    respond_to do |format|
      format.html 
    end
  end

  # PUT - updates an existing
  def update
    if request.put?
      @templ=Sitetemplate.find(params[:id])
      if @templ
        @templ.update_attributes(params[:templ])
        redirect_to :action=>"index", :controller=>"admin/templates"
      end
    end
  end

  # DELETE - deletes
  def destroy
    if request.delete?
      @templ=Sitetemplate.find(params[:id])
      @templ.destroy
      redirect_to :action=>"index", :controller=>"admin/templates"
    end
  end

end
