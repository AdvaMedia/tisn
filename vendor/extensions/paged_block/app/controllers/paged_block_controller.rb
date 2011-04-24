# To change this template, choose Tools | Templates
# and open the template in the editor.

class PagedBlockController < PageController
  layout :get_layout
  before_filter :init_page, :only=>:index

  def index
    @tgroup=@page.tabgroups.first
  end

  def for_block
    @tabgroup = Tabgroup.find_by_id(params[:id])
    if @tabgroup
      @tab = @tabgroup.tabitems.select{|tab| tab.tag==params[:tag]}.first
    else
      render :text=>"Вкладка не найдена"
    end
  end

  protected
  def get_layout
    if request.xhr?
      return nil
    end
    unless @page.blank?
      "#{@page.template}/template"
    else
      nil
    end
  end

  
end
