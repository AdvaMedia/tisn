class Admin::HtmlblockController < AdminExtController

  # GET
  def index
    @rootpage=Page.find_by_parent_id(nil)
    respond_to  do  |format|
      format.html  #index.html.erb
    end
  end

  # GET
  def show
    @actpage=Page.find(params[:id])
    @html_parts=[]
    @actpage.page_parts.each do |pp|
      pp.part_items.each do |pi|
        if pi.modul and pi.modul.tagname=="html"
          @html_parts << pi
        end
      end
    end
  end

  def new
    if params[:part_id]
      @htmlblock=HtmlBlock.new(:part_item_id=>params[:part_id].to_i)
    else
      render :text=>"Ошибочка... невозможно инициировать блок..."
    end
  end

  # POST
  def create
    @htmlblock=HtmlBlock.new
    if request.post?
      if @htmlblock.update_attributes(params[:htmlblock])
        redirect_to :controller=>"admin/htmlblock",  :action=>"show", :id=>@htmlblock.part_item.page_part.page.id
      end
    end
  end

  #GET
  def edit
    @htmlblock=HtmlBlock.find(params[:id])
  end

  # PUT
  def update
    @htmlblock=HtmlBlock.find(params[:id])
    if request.put?
      if @htmlblock.update_attributes(params[:htmlblock])
        redirect_to :controller=>"admin/htmlblock",  :action=>"show", :id=>@htmlblock.part_item.page_part.page.id
      end
    end
  end

  # DELETE
  def destroy
  end

end
