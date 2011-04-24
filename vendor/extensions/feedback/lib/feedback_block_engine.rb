# To change this template, choose Tools | Templates
# and open the template in the editor.

class FeedbackBlockEngine
  include ActionController::UrlWriter
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  attr_accessor :block, :tag, :index

  def initialize(blockitem, tagitem, itemindex)
    @block=blockitem
    @tag = tagitem
    @index = itemindex
  end

  def render
    ""
  end

  class << self
    def edit_link_params(blockitem)
      result={}
    end
  end
end
