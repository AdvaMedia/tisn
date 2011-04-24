class Admin::PagepartsController < AdminExtController
  include LoginSystem
  prepend_before_filter :authorize, :adminuser

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
    session[:container_backurl]=request.request_uri
  end


  def new
    @page=Page.find(params[:page_id])
    @part=PagePart.new(:page=>@page, :name=>params[:cont_name])
    @back_url=session[:container_backurl]
  end

  # POST
  def create
    if request.post?
      @part=PagePart.new
      @part.update_attributes(params[:part])
      redirect_to :action => "show", :controller=>"admin/pageparts", :id=>@part.page.id
    end
  end

  #GET
  def edit
    @selpage=Page.find(params[:id])
    @container_name=params[:named_part]
    @part=nil
    @selpage.page_parts.each do |part|
      @part=part if part.name==params[:named_part]
    end
    @part||=PagePart.create(:page=>@selpage, :name=>@container_name)
  end

  # PUT
  def update
    if request.put?
      @part=PagePart.find(params[:id])
      @part.update_attributes(params[:part])
      redirect_to :action => "show", :controller=>"admin/pageparts", :id=>@part.page.id
      #link_to  page.title,  :controller=>"admin/pageparts",  :action=>"show",  :id=>page.id
    end
  end

  # DELETE
  def destroy
  end

end
