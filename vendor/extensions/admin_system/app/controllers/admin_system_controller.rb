# To change this template, choose Tools | Templates
# and open the template in the editor.

class AdminSystemController  < AdminSystemControllerExt

  layout "admin"
  #include AuthenticatedSystem
  def index
    
  end

  def login
    if request.post?
      logout_keeping_session!
      user = User.authenticate(params[:login], params[:password])
      if user
        # Protects against session fixation attacks, causes request forgery
        # protection if user resubmits an earlier form using back
        # button. Uncomment if you understand the tradeoffs.
        # reset_session
        self.current_user = user
        #new_cookie_flag = (params[:remember_me] == "1")
        #handle_remember_cookie! new_cookie_flag
        #render :action=>"confirm"
        redirect_to :action=>"index"
      end
    end
  end

  def confirm
    if request.post?
      redirect_to :action=>"index"
    end
  end

  def logout
    logout_killing_session!
    #flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

  def show_room
    @room = A2mCms::ExtensionLoader.grouped_extensions.select{|ge| ge[0]==params[:room]}.first
  end
end
