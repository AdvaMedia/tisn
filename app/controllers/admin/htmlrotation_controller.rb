class Admin::HtmlrotationController < AdminExtController

  #get
  def index
    @rotates=HtmlRotation.find(:all)
  end

  #get
  def show
  end

  #get
  def new
    @rotateitem=HtmlRotation.new
  end

  #post
  def create
    @rotateitem=HtmlRotation.new
    if request.post?
      if @rotateitem.update_attributes(params[:rotateitem])
        redirect_to :action=>"index", :controller=>"htmlrotation"
      end
    end
  end

  #get
  def edit
    @rotateitem=HtmlRotation.find(params[:id])
  end

  #put
  def update
    @rotateitem=HtmlRotation.find(params[:id])
    if @rotateitem
      if @rotateitem.update_attributes(params[:rotateitem])
        redirect_to :action=>"index", :controller=>"htmlrotation"
      end
    end
  end

  #delete
  def destroy
    @rotateitem=HtmlRotation.find(params[:id])
    if @rotateitem
      @rotateitem.destroy
      redirect_to :action=>"index", :controller=>"htmlrotation"
    end
  end

end
