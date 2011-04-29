require 'liquid'
class FaqBlockEngine
  include ActionController::UrlWriter
  attr_accessor :block, :tag, :index, :template, :template_name
  def initialize(blockitem, tagitem, itemindex)
    @block=blockitem
    @tag = tagitem
    @index = itemindex
    @template_name = "faq_block"
  end
  
  def render
    fname = File.dirname(__FILE__) + "/../app/views/liquid/#{@template_name}.html"
    @template = File.exist?(fname) ? File.read(fname) : ""
    paths = get_paths
    params = {}.merge('auth_key'=>"#{@tag.globals.page.response.template.controller.send :form_authenticity_token}").merge(@tag.globals.page.response.template.controller.send :params)
    
    @vips = Question.all(:order=>"position", :conditions=>{:vip => true})
    
    Liquid::Template.parse(@template).render(
      'paths'=>paths, 
      'compliant'=>Complaint.new(:owner=>"Ваше имя", :number=>"Номер договора", :contacts=>"Телефон для связи", :content=>"Опишите проблему", :dog_created=>"Дата заключения договора"), 
      'question'=>Question.new(:title=>"Введите в это поле Ваш вопрос", :content=>"Уточните ваш вопрос", :name=>"не забудьте указать Ваше имя", :mail=>"электронную почту", :contact=>"номер телефона"),
      'params'=>params, 
      'auth_token'=>params['auth_key'],
      'vips' => @vips,
      'newest' => Question.paginate(:per_page=>15, :order=>"position DESC", :page=>1, :conditions=>["answer not null and answer != :answer", {:answer=>""}])
      )
  end
  
  class << self
    def edit_link_params(blockitem)
      "#"
    end
  end
  
  private
  
  def get_paths
    {
      "complaint_form_action"=>faq_compliants_path(:format=>:json),
      "question_form_action"=>faq_questions_path(:format=>:json),
      "live_serarch_url"=>faq_live_search_path
    }
  end
end

class ComplaintDrop < Clot::BaseDrop
    liquid_attributes << :owner <<:number << :dog_created << :contacts << :content
end

class QuestionDrop < Clot::BaseDrop
    liquid_attributes << :title << :content << :answer << :id << :rate << :position << :created_at << :updated_at << :name << :mail << :contact << :timest
end