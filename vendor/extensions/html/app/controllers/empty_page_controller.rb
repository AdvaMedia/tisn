# To change this template, choose Tools | Templates
# and open the template in the editor.

class EmptyPageController < PageController
  layout :get_layout
  before_filter :init_page

  def index

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

  #def init_page
  #  url = params[:url]
  #  url = Page.parce_url(url)
  #  redirect_to :action=>'not_found', :controller=>'site' unless @page = Page.extract_by(url)
  #  true
  #end
end
