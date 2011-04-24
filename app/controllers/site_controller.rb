class SiteController < PageController

  layout :get_layout

  def show_page
    url = params[:url]
    url = Page.parce_url(url)

    redirect_to :action=>'not_found', :controller=>'site' unless @page=Page.find_by_full_url(url)
  end

  def not_found
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end

  def error
    render :text=>"error Action"
  end

  def parse(text)
    @page.parse(text)
  end

  private

  def process_page(page)
    if page.redirect.blank?
    page.process(request, response)
    else
      redirect_to page.redirect, :status=>page.status_code
    end
  end

  def get_layout
    "#{@page.template}/template"
  end
end
