# To change this template, choose Tools | Templates
# and open the template in the editor.

module InterviewTagsList
  unloadable
  include Taggable
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  #attr = tag.attr.symbolize_keys

  [:interview_block].each do |prefix|
    tag "#{prefix}" do |tag|
      result=""
      attr = tag.attr.symbolize_keys
      tag.locals.interview_block = Interviewblock.find_by_id(attr[:id]) unless attr[:id].blank?
      tag.locals.interview_block_result = attr[:result]
      result = tag.globals.page.parse(tag.locals.interview_block.template)
      result
    end

    [:interview].each do |postfix|
      tag "#{prefix}:#{postfix}" do |tag|
        unless tag.locals.interview_block_result
          result = []
          atts=""
          tag.attr.each_key {|key| atts+=" #{key}=\"#{tag.attr[key]}\""}
          unless tag.locals.interview_block.interview.blank?
            tag.locals.interview = tag.locals.interview_block.interview
            tmp_url = url_for(:controller=>InterviewExtension.index_controller, :action=>"vote", :url=>tag.globals.page.full_url)
            result << "<form#{atts} action='#{tmp_url}' method=\"post\" class=\"interview-form\">"
            result << tag.expand unless tag.locals.interview.blank?
            result << "</form>"
            result << "<script type=\"text/javascript\" src=\"/javascripts/#{InterviewExtension.extension_name}.js\"></script>"
          end
          result
        end
      end

      tag "#{prefix}:#{postfix}:name" do |tag|
        tag.locals.interview.name
      end

      tag "#{prefix}:#{postfix}:submit" do |tag|
        result = []
        result << "<button type=\"submit\" disabled=\"disabled\" class=\"hidden\">"
        result << tag.expand
        result << "</button>"
        result
      end

      [:variants].each do |variants|
        tag "#{prefix}:#{postfix}:#{variants}" do |tag|
          result=[]
          tag.locals.interview.interviewvariants.each_with_index do |item, index|
            tag.locals.interview_variant = item
            tag.locals.interview_variant_index = index
            result << tag.expand
          end
          result
        end
        tag "#{prefix}:#{postfix}:#{variants}:variant" do |tag|
          ret = ""
          unless tag.locals.interview_variant.blank?
            tmp_name = "vote"
            tmp_id= "variant-#{tag.locals.interview_variant_index}"
            ret= <<EOF
<input type="radio" name="#{tmp_name}" value="#{tag.locals.interview_variant.id}" id="#{tmp_id}" />
<label for="#{tmp_id}">#{tag.locals.interview_variant.content}</label>
EOF
          end
          ret
        end
      end
    end

    [:result].each do |postfix|
      tag "#{prefix}:#{postfix}" do |tag|
        if tag.locals.interview_block_result
          result = []
          atts=""
          tag.attr.each_key {|key| atts+=" #{key}=\"#{tag.attr[key]}\""}
          unless tag.locals.interview_block.interview.blank?
            tag.locals.interview = tag.locals.interview_block.interview
            result << tag.expand unless tag.locals.interview.blank?
          end
          result
        end
      end

      tag "#{prefix}:#{postfix}:name" do |tag|
        tag.locals.interview.name
      end

      [:variants].each do |variants|
        tag "#{prefix}:#{postfix}:#{variants}" do |tag|
          result=[]
          tag.locals.interview.interviewvariants.each_with_index do |item, index|
            tag.locals.interview_variant = item
            tag.locals.interview_variant_index = index
            result << tag.expand
          end
          result
        end
        tag "#{prefix}:#{postfix}:#{variants}:variant" do |tag|
          ret = ""
          unless tag.locals.interview_variant.blank?
            tmp_name = "vote"
            tmp_id= "variant-#{tag.locals.interview_variant_index}"
            ret= <<EOF
<div class="label">#{tag.locals.interview_variant.content}<span>#{tag.locals.interview_variant.percent}%</span></div>
<div class="track"><div style="width: #{tag.locals.interview_variant.percent}%;" class="progress"></div></div>
EOF
          end
          ret
        end
      end

    end
  end
end
