module FaqQuestionsHelper
  def sort_url
    order_type = ["position", "rate"].reject{|p| p == session[:questions_admin_order]}.first
    link_to "<span>по&nbsp;#{order_type == 'position' ? 'рейтингу' : 'релевантности'}</span>", admin_faq_questions_url(:order=>order_type), {:class=>"minibutton btn-watch"}
  end
end