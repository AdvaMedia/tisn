class FaqController < ApplicationController
  #protect_from_forgery :false
  def send_complaint
    ret = {:status=>:created, :errors=>[]}
    if request.xhr?
      unless params[:complaint].blank?
        complaint = Complaint.new(params[:complaint])
        if complaint.save
          ret[:status] = :created
        else
          ret[:errors] << "Не удалось сохранить претензию"
        end
      else
        ret[:errors] << "Не найден параметр претензии"
      end
    else
      ret[:errors] << "Сервер отклонил Ваш запрос!"
    end
    
    respond_to do |format|
      format.html { render :text => "Доступ запрещен..." }
      format.json {render :json=>ret, :status => ret[:status]}
    end
  end
  
  def send_question
    ret = {:status=>:created, :errors=>[]}
    if request.xhr?
      unless params[:question].blank?
        question = Question.new(params[:question])
        if question.save
          ret[:status] = :created
        else
          ret[:errors] << "Не удалось сохранить вопрос"
        end
      else
        ret[:errors] << "Не найден параметр вопроса"
      end
    else
      ret[:errors] << "Сервер отклонил Ваш запрос!"
    end
    respond_to do |format|
      format.html { render :text => "Доступ запрещен..." }
      format.json {render :json=>ret, :status => ret[:status]}
    end
  end
  
  def live_search
    prepare_search
    session[:live_search_page] = 1
    unless params[:q].blank?
      @ret = Question.search(params[:q], :match_mode => :phrase, :sort_mode => :boolean, :order=>"#{@live_search_order} DESC")
      @ret.map!{|i| i.voted = @vote_array.include?(i.id); i}
    end
    respond_to do |format|
      format.html {  }
      format.json { render :json=>@ret }
    end
  end
  
  def show_more
    prepare_search
    @show_message = false
    unless params[:skip_search]
      session[:live_search_page] = session[:live_search_page].blank? ? 1 : session[:live_search_page]+1
    end
    @ret = Question.paginate(:per_page=>5*session[:live_search_page], :order=>"#{@live_search_order} DESC", :page=>1, :conditions=>["answer not null and answer != :answer", {:answer=>""}])
    @ret.map!{|i| i.voted = @vote_array.include?(i.id); i}
    post_for_liquid
    render :live_search
  end
  
  def vote
    if request.xhr?
      @item = []
      unless params[:id].blank?
        session[:faq_vote_ids] ||= []
        @item = Question.find_by_id(params[:id])
        @item.vote! unless @item.blank?
        session[:faq_vote_ids] << @item.id if (!@item.blank? and !session[:faq_vote_ids].include? @item.id)
      end
  end
    respond_to do |format|
      format.html { render :text=>"Доступ запрещен" if @item.blank? }
      format.json { render :json=>@item }
    end
  end
  
  private
  
  def prepare_search
    @ret = []
    @show_message = true
    @vote_array = session[:faq_vote_ids] ||= []
    session[:live_search_order] ||= "position"
    session[:live_search_order] = params[:order] if !params[:order].blank? and %{position rate}.include? params[:order]
    @live_search_order = session[:live_search_order]
    @faq_show_more_url = faq_show_more_path
  end
  
  def post_for_liquid
    @news_all_pages = @ret.total_pages
    @newst_page = session[:live_search_page]
  end
end