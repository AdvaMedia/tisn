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
      'compliant'=>Complaint.new(:owner=>"Unknown user"), 
      'question'=>Question.new,
      'params'=>params, 
      'auth_token'=>params['auth_key'],
      'vips' => @vips
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
    liquid_attributes << :owner
end

class QuestionDrop < Clot::BaseDrop
    liquid_attributes << :title << :content << :answer << :id
end