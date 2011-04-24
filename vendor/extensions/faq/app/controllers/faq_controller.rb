# To change this template, choose Tools | Templates
# and open the template in the editor.

class FaqController < PageController
  layout :get_layout
  before_filter :init_page, :only=>[:index, :get_form, :send_faq]
  
  def get_form
    unless request.xhr?
      render :text=>""
    else
      @item = Faq.new
    end
  end

  def send_faq
    init_page
    @item = Faq.new
    if request.xhr? and request.post?
      @item.update_attributes(params[:item])
    end
  end

  def index
    @page_num = params[:page].gsub("page-", "").to_i||1
    @items = Faq.all(:conditions=>['answer IS NOT NULL']).paginate(:per_page=>15, :page=>@page_num)
    @item = Faq.new
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
