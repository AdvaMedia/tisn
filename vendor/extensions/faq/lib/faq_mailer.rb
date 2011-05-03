class FaqMailer < ActionMailer::Base
  
  def faq_messages(sent_from='tisn@advamedia.ru',sent_recipients='kirillov@advamedia.ru', sent_subject='Информация о поступивших вопросах и претензиях', sent_body={"current_date"=>Time.now, "company"=>"Окна ТиСН", "site"=>{"name"=>"Окна ТиСН"}}, sent_at = Time.now)
    @content_type   = "text/html"
    @from       = sent_from
    @recipients = sent_recipients
    @subject    = sent_subject
    @body       = sent_body
    @sent_on    = sent_at
    @headers    = {}
  end
  
  def render_message(method_name, body)
    fname = File.dirname(__FILE__) + "/../app/views/liquid/#{method_name}.html"
    mailtemplate = File.exist?(fname) ? File.read(fname) : ""
    template = Liquid::Template.parse(mailtemplate)
    template.render body
  end
end