class Admin::PartItemsController < AdminExtController

  # GET
  def index
  end

  # GET
  def show
    @partitem=PartItem.find(params[:id])
    if @partitem
      @named_part=@partitem.page_part.name
      @pid=@partitem.page_part.page.id
    end
  end


  def new
    @parentpart=PagePart.find(params[:parent_part_id])
    if @parentpart
      @newpartitem=PartItem.new(:page_part=>@parentpart)
      respond_to do |format|
        format.html #html
      end
    end
  end

  # POST
  def create
    if request.post?
      @newpartitem=PartItem.new
      @newpartitem.update_attributes(params[:newpartitem])
      max_order=PartItem.maximum(:order_num, :conditions=>{:page_part_id=>@newpartitem.page_part_id})
      @newpartitem.order_num=max_order+1
      @newpartitem.save
      redirect_to :action=>"edit", :controller=>"admin/pageparts", :named_part=>@newpartitem.page_part.name, :id=>@newpartitem.page_part.page.id
    end
  end

  #GET
  def edit
    @partitem=PartItem.find(params[:id])
  end

  # PUT
  def update
  end

  # DELETE
  def destroy
    @partitem=PartItem.find(params[:id])
    if @partitem
      @named_part=@partitem.page_part.name
      @pid=@partitem.page_part.page.id
      if request.delete?
        if @partitem.destroy
          redirect_to :action=>"edit", :controller=>"admin/pageparts", :named_part=>@named_part, :id=>@pid
        end
      end
    end
  end

end
