# To change this template, choose Tools | Templates
# and open the template in the editor.

class FeedbackMessage
  attr_accessor :name, :phone, :mail, :theme, :content
  def initialize(params)
    @name = params[:name]
    @phone = params[:phone]
    @mail = params[:mail]
    @theme = params[:theme]
    @content = params[:message]
  end

  def send
    mailmessage = "Вам пришло сообщение от посетителя: #{@name}\n\r"
    mailmessage += "Телефон для связи: #{@phone}\n\r"
    mailmessage += "или по электронному адресу: #{@mail}\n\r" unless @mail.blank?
    mailmessage += "\n\r\n\r"
    mailmessage += "#{@content}\n\r"
    mailmessage += "---"
    p "try to send message from #{A2mConfiguration.get_value(FeedbackExtension.extension_name, "mail", "postmaster@advamedia.ru")}"
    Emailer.deliver_contact(A2mConfiguration.get_value(FeedbackExtension.extension_name, "mail", "postmaster@advamedia.ru"),
      @theme,
      mailmessage,
      "tisn@advamedia.ru"
    )
  end
end
