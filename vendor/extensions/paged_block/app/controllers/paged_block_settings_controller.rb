# To change this template, choose Tools | Templates
# and open the template in the editor.

class PagedBlockSettingsController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def for_block
    @block = Pageblock.find_by_id(params[:id])
    if request.post?
      @tgroup = Tabgroup.find_by_id(params[:tabsgroup_id])
      if @tgroup.blank?
       
      else
        @block.tabgroups = [@tgroup]
        @block.save
        redirect_to :action=>"index", :controller=>"PagedBlockTabs", :id=>@tgroup.id
      end
    end
  end

  def for_page
    @block = Page.find_by_id(params[:id])
    if request.post?
      @tgroup = Tabgroup.find_by_id(params[:tabsgroup_id])
      if @tgroup.blank?

      else
        @block.tabgroups = [@tgroup]
        @block.save
        redirect_to :action=>"index", :controller=>"PagedBlockTabs", :id=>@tgroup.id
      end
    end
  end
end
