class ContactsController < ApplicationController
  def get_form
  end

  def send_contact
    @retmessage=""
    if request.post?
      @retmessage="Ваше сообщение успешно отправлено! Спасибо!"
      if params['mail'].blank?
        text_to_message=<<EOF
      Сообщение от: #{params['myname']} (контактный телефон:#{params['myphone']}, контактный e-mail:#{params['mymail']})\n
Сообщение:\n
#{params['mymessage']}
EOF
        Emailer.deliver_contact("info@werdau.ru","Получено сообщение от пользователя сайта.", text_to_message)
      else
        @retmessage="Не удалось отправить сообщение! Попробуйте попозже."
      end
    end
  end

end
