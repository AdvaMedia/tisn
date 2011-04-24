class Admin::WelcomeController < AdminController
  layout 'admin_root'
  def index
    
  end

  def logout
    session['user_id']=nil
    redirect_to :controller=>"site", :action=>"show_page", :url => ''
  end

end
