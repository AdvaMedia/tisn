# To change this template, choose Tools | Templates
# and open the template in the editor.

module AdminLoginSystem
  def current_user
    @current_user ||= login_from_session
  end

  def current_user=(value=nil)
    if value && value.is_a?(User)
      @current_user = value
      session['user_id'] = value.id
    else
      @current_user = nil
      session['user_id'] = nil
    end
    @current_user
  end

  def self.login_from_session
    User.find(session['user_id']) rescue nil
  end

  #Проверяем пользователь администратор или нет...
  def is_admins
    admrole=Role.find_by_name("Admins")
    if current_user==nil or admrole==nil
      return false
    end

    return current_user.roles.include?(admrole)

  end

  def authorize
    unless User.find_by_id(session['user_id'])
      session[:original_url]=request.request_uri
      flash[:notice]="Для доступа, пожалуйста пройдите авторизацию"
      redirect_to(:controller=>"AdminSystem", :action=>"login")
    end
  end
end
