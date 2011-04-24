# To change this template, choose Tools | Templates
# and open the template in the editor.

class PublicationsController < PageController
  layout :get_layout
  before_filter :init_page, :only=>:index

  def index
    @render_template=""
    @page.page_number = params[:page].gsub("page-", "").to_i
    unless params[:tab].blank?
      @page.publication_tag = (Publicationitem.all :joins=>:publicationgroup, :conditions=>{
          :publicationgroup_id=>@page.publicationpages.first.publicationgroup.id,
          :tag=>params[:tab]
        }).first
      @render_template = @page.publicationpages.first.template_one if @page.publicationpages.length > 0
    else
      @render_template = @page.publicationpages.first.template_all if @page.publicationpages.length > 0
    end

    respond_to do |format|
      format.html
      format.rss  {
        @items = @page.publicationgroups.first.publicationitems if @page.publicationgroups.length >0
        render :layout => false

        }
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
