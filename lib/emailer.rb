# To change this template, choose Tools | Templates
# and open the template in the editor.

class Emailer < ActionMailer::Base
  def contact(recipient, subject, message, from, sent_at = Time.now)
      @subject = subject
      @recipients = recipient
      @from = from
      @sent_on = sent_at
      @body["title"] = subject
  	  @body["email"] = from
   	  @body["message"] = message
      @headers = {}
   end

end
