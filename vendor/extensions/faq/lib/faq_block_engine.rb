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
    
    @tag.globals.page.response.session[:live_search_page] = 1
    @tag.globals.page.response.session[:faq_vote_ids] ||= []
    @vote_array = @tag.globals.page.response.session[:faq_vote_ids]
    
    @vips = Question.all(:order=>"position", :conditions=>{:vip => true})
    @newest = Question.paginate(:per_page=>5, :order=>"position DESC", :page=>1, :conditions=>["answer not null and answer != :answer", {:answer=>""}])
    @newest.map!{|i| i.voted = @vote_array.include?(i.id); i}
    Liquid::Template.parse(@template).render(
      'paths'=>paths, 
      'compliant'=>Complaint.new(:owner=>"Ваше имя", :number=>"Номер договора", :contacts=>"Телефон для связи", :content=>"Опишите проблему", :dog_created=>"Дата заключения договора"), 
      'question'=>Question.new(:title=>"Введите в это поле Ваш вопрос", :content=>"Уточните ваш вопрос или оставьте поле пустым", :name=>"не забудьте указать Ваше имя", :mail=>"электронную почту", :contact=>"номер телефона"),
      'params'=>params, 
      'auth_token'=>params['auth_key'],
      'vips' => @vips,
      'newest' => @newest,
      'newst_page' => 1,
      'news_all_pages' => @newest.total_pages,
      'live_search_order' => 'position'
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
      "live_serarch_url"=>faq_live_search_path,
      "faq_show_more_url" => faq_show_more_path,
      "faq_vote_path"=>faq_vote_path
    }
  end
end

class ComplaintDrop < Clot::BaseDrop
    liquid_attributes << :owner <<:number << :dog_created << :contacts << :content
end

class QuestionDrop < Clot::BaseDrop
    liquid_attributes << :title << :content << :answer << :id << :rate << :position << :created_at << :updated_at << :name << :mail << :contact << :timest << :voted
end