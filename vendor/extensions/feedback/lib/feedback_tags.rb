# To change this template, choose Tools | Templates
# and open the template in the editor.

module FeedbackTags
  unloadable
  include Taggable

  class TagError < StandardError; end

  tag 'feedback' do |tag|
    result =""
    result << "<script type=\"text/javascript\" src=\"/javascripts/#{FeedbackExtension.extension_name}.js\"></script>"
    result << "<a class=\"contact-us\" href=\"#{url_for(:action=>"get_form", :controller=>"Feedback")}\">Написать нам</a>"
    result
  end
end
