# To change this template, choose Tools | Templates
# and open the template in the editor.

class FeedbackAdminController < AdminSystemControllerExt
  layout "admin"
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    get_settings
    if request.post?
      set_settings
      get_settings
      flash[:notice]="Изменения применены"
    end
  end

  private
  def get_settings
    @mail = A2mConfiguration.get_value(FeedbackExtension.extension_name, "mail", "postmaster@advamedia.ru")
    @title = A2mConfiguration.get_value(FeedbackExtension.extension_name, "title", "Сообщение обратной связи с сайта")
    @active = A2mConfiguration.get_value(FeedbackExtension.extension_name, "active", "1")
  end

  def set_settings
    A2mConfiguration.set_value(FeedbackExtension.extension_name, "mail", params[:mail])
    A2mConfiguration.set_value(FeedbackExtension.extension_name, "title", params[:title])
    A2mConfiguration.set_value(FeedbackExtension.extension_name, "active", params[:active])
  end

end
