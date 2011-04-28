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
    @ret = []
    unless params[:q].blank?
      @ret = Question.search(params[:q])#, :match_mode => :any
    end
    respond_to do |format|
      format.html {  }
      format.json { render :json=>@ret }
    end
  end
end