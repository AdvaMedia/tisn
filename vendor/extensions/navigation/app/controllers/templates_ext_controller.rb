# To change this template, choose Tools | Templates
# and open the template in the editor.

class TemplatesExtController < ApplicationController
  include AuthenticatedSystem
  before_filter :admin_login_required

  def index
    @templates = A2mCms::TemplatesLoader.loaded_templates
    respond_to do |format|
      format.html
    end
  end

  #get
  def add_template
    @templ = "template-name"
  end

  #post
  def create
    if request.post?
      unless A2mCms::TemplatesLoader.loaded_templates.include? params[:name]

        redirect_to :action=>"index"
      end
    end
  end

  def edit
    preedit
    @templ_content = File.open(@templ_path, 'r') {|f| f.read }
  end

  #post
  def save
    preedit
    if request.post?
      File.open(@templ_path, 'w') {|f| f.write(params[:templ_content]) }
      A2mCms::CoreManager.restart
      redirect_to :action=>"index"
    end
  end

  def preedit
    @templ = params[:id]
    trypath = File.join(RAILS_ROOT,"public","templates","layouts",@templ,"template.erb")
    @templ_path = File.exist?(trypath) ? trypath : nil
    redirect_to :action=>"index" unless @templ_path
  end
end
