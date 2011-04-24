# To change this template, choose Tools | Templates
# and open the template in the editor.
class ApplicationControllerExt < ApplicationController
  
  include Taggable
  include BaseTags
  after_filter :parce

  def parce
    @context = TagsContent.new(self)
    @parser = Radius::Parser.new(@context, :tag_prefix => 'a2m')

    response.body=@parser.parse(response.body.to_s)
  end
end
