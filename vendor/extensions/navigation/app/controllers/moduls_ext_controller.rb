# To change this template, choose Tools | Templates
# and open the template in the editor.

class ModulsExtController < ApplicationController
  include AuthenticatedSystem
  before_filter :admin_login_required

  def show_moduls
    @selpage=Page.find(params[:id])
  end

  def add_module
    
  end

  def add_module_in_empty
    @selpage=Page.find(params[:id])
    @part=PagePart.create(:page_id=>@selpage.id, :name=>params[:mname])
    redirect_to :action=>"add_module_in_exist", :mid=>@part.id
  end

  def add_module_in_exist
    @part=PagePart.find(params[:mid])
    @newpartitem=PartItem.new(:page_part_id=>@part.id)
  end

  def insert_module
    add_module_in_exist
    if request.post?
      if @newpartitem.update_attributes(params[:newpartitem])
        redirect_to :action=>"show_moduls", :id=>@part.page.id
      end
    end
  end

  def qdelete_module
    @spartitem = PartItem.find(params[:mid])
  end

  def delete_module
    qdelete_module
    if request.post?
      @pid=@spartitem.page_part.page.id
      if @spartitem.destroy
        redirect_to :action=>"show_moduls", :id=>@pid
      end
    end
  end

end
