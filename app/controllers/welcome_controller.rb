class WelcomeController < ApplicationController
  def index
    if request.post?
      @username=params[:login_name]
      @password=params[:password]
      if @username.blank? or @password.blank?
        flash[:notice]="Имя пользователя или пароль не могут быть пустыми"
        render :action=>"index"
      else
        user=User.authenticate(@username, @password)
        if user
          session['user_id']=user.id
          flash[:notice]=nil
          url=session[:original_url]
          session[:origonal_url]=nil
          redirect_to(url || {:controller=>"root_page", :action=>"index", :url=>nil})
        else
          flash[:notice]="Неправильно введены имя пользователя или пароль"
        end
      end
    end
  end
end
