# To change this template, choose Tools | Templates
# and open the template in the editor.

class PageController < ApplicationController
  include Taggable
  include BaseTags
  include AuthenticatedSystem

  after_filter :parce
  attr_accessor :skip_parsing

  def initialize
    A2mCms::ExtensionLoader.tags_classes.each do |tagclass|
      class_eval {include tagclass}
    end
  end

  def parce
    if @page and response.redirected_to.blank?
      @page.current_user=current_user
      @page.pre_process(request, response)
      response.body=@page.parse(response.body.to_s)
    end
  end

  def init_page
    url = params[:url]
    url = Page.parce_url(url)
    redirect_to :action=>'error', :controller=>'GlobalSettings' unless @page = Page.extract_by(url)
    true
  end
end
