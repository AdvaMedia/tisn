# To change this template, choose Tools | Templates
# and open the template in the editor.

class InterviewController < PageController
  layout :get_layout
  before_filter :init_page, :only=>:vote
  protect_from_forgery :except=>[:vote]
  
  def vote
    @error_vote = true
    if request.xhr? and request.post?
      unless params[:vote].blank?
        variant = Interviewvariant.find_by_id(params[:vote].to_i)
        unless variant.blank?
          variant.vote = variant.vote+1
          @error_vote = variant.save
          @interview_id = variant.interview.id
        end
      end
    else
      render :text=>"Не поддерживаемый запрос"
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
