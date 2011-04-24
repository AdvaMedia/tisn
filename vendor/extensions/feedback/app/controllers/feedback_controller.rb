# To change this template, choose Tools | Templates
# and open the template in the editor.

class FeedbackController < ApplicationController
  def get_form
    unless request.xhr?
      render :text=>""
    end
  end

  def send_feedback
    if request.xhr? and request.post?
      message = FeedbackMessage.new(params)
      message.send if A2mConfiguration.get_value(FeedbackExtension.extension_name, "active", "1")=="1"
    end
  end
end
