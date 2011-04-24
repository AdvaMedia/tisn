class Admin::OrdersController < ApplicationController

  #get
  def index
    @orders=Order.find(:all)
    if @orders
      respond_to do |format|
        format.html #index.html
      end
    end
  end

  #get
  def show
    @order=Order.find(params[:id])
    if @order
      respond_to do |format|
        format.html #index.html
      end
    end
  end

  #get
  def new
    @order = Order.new
  end

  #post
  def create
    @order = Order.new
    if request.post?
      if @order.update_attributes(params[:order])
        redirect_to :action=>"index", :controller=>"admin/orders"
      end
    end
  end

  #get
  def edit
    @order = Order.find(params[:id])
  end

  #put
  def update
    @order = Order.find(params[:id])
    if request.put?
      if @order.update_attributes(params[:order])
        redirect_to :action=>"index", :controller=>"admin/orders"
      end
    end
  end

  #delete
  def destroy
    @order = Order.find(params[:id])
    if request.delete?
      if @order.destroy
        redirect_to :action=>"index", :controller=>"admin/orders"
      end
    end
  end

end
