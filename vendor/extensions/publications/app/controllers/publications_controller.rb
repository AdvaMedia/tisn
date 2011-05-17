# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'liquid'
class PublicationsController < PageController
  layout :get_layout
  before_filter :init_page, :only=>:index

  def index
    @render_template=""
    @page.page_number = 1
    @page.page_number = params[:page].gsub("page-", "").to_i
    unless params[:tab].blank?
      @page.publication_tag = (Publicationitem.all :joins=>:publicationgroup, :conditions=>{
          :publicationgroup_id=>@page.publicationpages.first.publicationgroup.id,
          :tag=>params[:tab]
        }).first
      @render_template = Rails.cache.fetch("publication-#{@page.publication_tag.id}", :expires_in => 12.hours){
        Liquid::Template.parse(@page.publicationpages.first.template_one).render('publication'=>@page.publication_tag, 'others'=>@page.publication_tag.publicationgroup.publicationitems.reject{|i| i==@page.publication_tag}) if @page.publicationpages.length > 0
      }
    else
      @render_template = Rails.cache.fetch("#publications-#{@page.publicationpages.first.publicationgroup.id}-#{@page.page_number}", :expires_in => 12.hours){
        pubitems = @page.publicationpages.first.publicationgroup.publicationitems
        all_publications = pubitems.paginate(:page=>@page.page_number, :per_page=>5)
        #Liquid::Template.parse(@page.publicationpages.first.template_all).render('lockeds'=>pubitems.locked, 'unlockeds'=>pubitems.unlocked, 'first'=>pubitems.first, 'group'=>@page.publicationpages.first.publicationgroup) if @page.publicationpages.length > 0
        Liquid::Template.parse(@page.publicationpages.first.template_all).render(
          'publications'=>all_publications, 
          'total_pages'=>all_publications.total_pages,
          'this_page'=>@page.page_number,
          'page_full_url' => @page.full_url,
          'group'=>all_publications.first.publicationgroup) if all_publications.length > 0
      }
    end

    respond_to do |format|
      format.html {
        
      }
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
