# To change this template, choose Tools | Templates
# and open the template in the editor.

class NavWidNodesAdminController < ApplicationController
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @navitem = Navigate.find_by_id(params[:id])
    redirect_to :action=>"index", :controller=>"NavividgetAdmin" if @navitem.blank?
  end
  
  def new
    @node = Navinode.new
    @navitem = Navigate.find_by_id(params[:id])
    if params[:parent]
      @parentnode = Navinode.find_by_id(params[:parent])
      redirect_to :back if @parentnode.blank?
      @node.parent_id = params[:parent]
    else
      if @navitem
        @node.navigate_id = @navitem.id
      else
        redirect_to :back
      end
    end
  end

  def save
    @node = Navinode.new
    post_save
  end

  def edit
    @node = Navinode.find_by_id(params[:id])
    @navitem = @node.get_navigate
  end

  def update
    @node = Navinode.find_by_id(params[:id])
    post_save
  end

  def destroy
    @node = Navinode.find_by_id(params[:id])
    @navitem = @node.get_navigate
    if request.post?
      nid = @navitem.id
      @node.destroy
      redirect_to :action=>"index", :id=>nid
    end
  end

  private
  
  def post_save
    @node.update_attributes(params[:node])
    redirect_to :action=>"index", :id=>@node.get_navigate.id
  end
end
