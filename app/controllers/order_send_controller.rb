class OrderSendController < ApplicationController

  #post
  def get_form
    if params[:id]
      @order_named_id=params[:id]
    else
      render :text=>"Ошибочка вышла..."
    end
  end

  #post gsub("buylink_","").to_i
  def send_order
    if request.post?
      if params[:id]
        @orderid=params[:id].gsub("buylink_","").to_i
        @orderitem=Order.find(@orderid)
        if @orderitem and !params[:order_name].blank? and !params[:order_phone].blank? and !params[:order_comment].blank? and params[:order_mail].blank?

          zayavka=<<EOF
          Заявка на -#{@orderitem.name}-
          От: #{params[:order_name]} (телефон: #{params[:order_phone]}):
          #{params[:order_comment]}
EOF

          msenders = A2mConfiguration.get_value(OrdersExtension.extension_name, "mails","post@localhost")
          msenders.split(" ").each do |msender|
            Emailer.deliver_contact(msender, "Зарегистрирована новая заявка",zayavka)
          end

          render :text=> <<EOF
<h3><font color=\"black\">Уважаемый(-я), </font>#{params[:order_name]}!</h3>
<p>Ваша заявка на <b>#{@orderitem.name}</b></p>
<h3>Успешно зарегистрирована!</h3>
<p>Мы свяжемся с <b>Вами</b> в ближайшее время.</p>
EOF
        else
          render :text=>"Не получилось отправить заявку... попробуйте попозже"
        end
      end
    else
      render :text=>"Не получилось отправить заявку... попробуйте попозже"
    end
  end

end
