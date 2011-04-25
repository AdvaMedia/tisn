#    admin_faq_questions GET    /admin/content/faq/questions(.:format)                    {:controller=>"faq_questions", :action=>"index"}
#                        POST   /admin/content/faq/questions(.:format)                    {:controller=>"faq_questions", :action=>"create"}
# new_admin_faq_question GET    /admin/content/faq/questions/new(.:format)                {:controller=>"faq_questions", :action=>"new"}
#edit_admin_faq_question GET    /admin/content/faq/questions/:id/edit(.:format)           {:controller=>"faq_questions", :action=>"edit"}
#     admin_faq_question GET    /admin/content/faq/questions/:id(.:format)                {:controller=>"faq_questions", :action=>"show"}
#                        PUT    /admin/content/faq/questions/:id(.:format)                {:controller=>"faq_questions", :action=>"update"}
#                        DELETE /admin/content/faq/questions/:id(.:format)                {:controller=>"faq_questions", :action=>"destroy"}
#
class FaqQuestionsController< AdminSystemControllerExt
 layout "admin"
 include AuthenticatedSystem
 before_filter :admin_login_required
 
 def index
  @ready = Question.paginate(:order=>"position", :conditions=>["answer not null and answer != :answer", {:answer=>""}], :page=>params[:page], :per_page=>20)
  @new_questions = Question.paginate(:order=>"position", :conditions=>["answer is null or answer == :answer", {:answer=>""}], :page=>1)
  respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @questions }
  end
 end
 
 def new
  @question = Question.new(params[:question])
  respond_to do |format|
    format.html # new.html.erb
    format.xml  { render :xml => @question }
  end
 end
 
 def create
  @question = Question.new(params[:question])
  respond_to do |format|
    if @question.save
      format.html { redirect_to(admin_faq_questions_url, :notice => 'Question was successfully created.') }
      format.xml  { render :xml => @question, :status => :created, :location => @question }
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
    end
  end
 end
 
 def show
  edit
  respond_to do |format|
    format.html # show.html.erb
    format.xml  { render :xml => @question }
  end
 end
 
 def edit
  @question = Question.find_by_id(params[:id])
 end
 
 def update
  edit
  respond_to do |format|
    if @question.update_attributes(params[:question])
      format.html { redirect_to(admin_faq_questions_url, :notice => 'Question was successfully updated.') }
      format.xml  { head :ok }
    else
      format.html { render :action => "edit" }
      format.xml  { render :xml => @respond_to.errors, :status => :unprocessable_entity }
    end
  end
 end
 
 def destroy
   edit
   @question.destroy
   respond_to do |format|
     format.html { redirect_to(admin_faq_questions_url) }
     format.xml  { head :ok }
   end
 end
  
 def move_to
    begin
      edit
      case params[:direction]
      when "up"
        @question.move_higher
      when "down"
        @question.move_lower
      end  
    rescue Exception => e
      
    end
    
    respond_to do |format|
      #format.html { redirect_to(admin_faq_questions_url) }
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
end