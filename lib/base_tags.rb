# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'bluecloth'
require 'geoip'

module BaseTags
  unloadable
  include Taggable

  class TagError < StandardError; end

  desc %{}
  tag 'yield' do |tag|
    "<%= yield -%>"
  end

  desc %{Adding a javascript tags and images to page}
  tag 'ajax' do |tag|
    "<script type=\"text/javascript\" src=\"/javascripts/mootools-1.2-core.js\"></script>"+
      "<script type=\"text/javascript\" src=\"/javascripts/mootools-1.2-more.js\"></script>"+
      "<script type=\"text/javascript\" src=\"/javascripts/fullajax.js\"></script>"+
      "<script type=\"text/javascript\" src=\"/javascripts/roar/roar.js\"></script>"
  end

  desc %{Тэг для включения валидации formcheck}
  tag 'formcheck' do |tag|
    ret="<script type=\"text/javascript\" src=\"/javascripts/formcheck/formcheck.js\"></script>"
    ret << "<script type=\"text/javascript\" src=\"/javascripts/formcheck/lang/#{tag.attr['lang']||='en'}.js\"></script>"
    ret<<"<link rel=\"stylesheet\" href=\"/css/formcheck/theme/#{tag.attr['theme']||='classic'}/formcheck.css\" type=\"text/css\" media=\"screen\" />"
    ret
  end

  #  desc %{Child navigation}
  #  tag 'navigation' do |tag|
  #    page=tag.locals.page
  #    rootpage=Page.find_by_parent_id(nil)
  #
  #    ret="<ul id=\"subnav\" class=\"box\">"
  #    rootpage.children.each do |cp1|
  #      isactive=cp1.has_child_page(page)
  #      ret+="<li>"
  #        ret+="<a href='/#{cp1.full_url}'>#{cp1.title}</a>"
  #        if isactive and cp1.children.length>0
  #          ret+="<ul>"
  #          cp1.children.each do |cp2|
  #            ret+="<li#{" class='active'" if cp2.id==page.id}>"
  #              ret+="<a href='/#{cp2.full_url}'>#{cp2.title}</a>"
  #            ret+="</li>"
  #          end
  #          ret+="</ul>"
  #        end
  #      ret+="</li>"
  #    end
  #    ret+="</ul>"
  #  end

  desc %{Page title tag}
  tag 'pagetitle' do |tag|
    result = ""
    unless tag.globals.page.blank?
      result = "<title>#{tag.globals.page.self_page_name}</title>"
    end
    result
  end

  desc %{keywords}
  tag 'pagekeywords' do |tag|
    "<meta name=\"keywords\" content=\"#{tag.locals.page.keywords}\" />" unless tag.locals.page
  end

  desc %{description}
  tag 'pagedescription' do |tag|
    "<meta name=\"description\" content=\"#{tag.locals.page.description}\" />" unless tag.locals.page
  end

  desc %{Дополнительный заголовок страницы}
  tag 'pageheader' do |tag|
    tag.globals.page.title
  end

  desc %{Tag for container(part) on page}
  tag 'container' do |tag|
    ret=""
    name=tag.attr['name']
    if name
      part=PagePart.find(:first, :conditions=>{:page_id=>tag.locals.page.id, :name=>name})
      if part
        part.part_items.each do |pitem|
          tmp_content = tag.locals.page.parse("<a2m:#{pitem.modul.tagname} partitem=\"#{pitem.id}\" />")
          ret+=<<OEF
<div id="block-#{pitem.modul.tagname}-#{pitem.order_num.to_i}" class="block#{" "+pitem.extclass unless pitem.extclass.blank? }">
#{tmp_content}
</div>
OEF
        end
      end
    end
    ret
  end

  desc %{HTML text in page}
  tag 'html' do |tag|
    ret=""
    if tag.attr['partitem']
      partitem=PartItem.find(tag.attr['partitem'].to_i)
      if partitem
        htmlblock=HtmlBlock.find(:first, :conditions=>{:part_item_id=>partitem.id})
        if htmlblock
          ret+=tag.locals.page.parse(htmlblock.content)
        end
      end
    end
    ret
  end

  desc %{Ротация HTML контента}
  tag 'htmlrotation' do |tag|
    ret=""
    title=nil
    title=tag.attr['title'] if tag.attr['title']

    ret+="<h3>#{title}:</h3>" if title

    ret+=HtmlRotation.random
    ret
  end

  desc %{breadcrumbs
  title="mytitle"
  }
  tag 'breadcrumbs' do |tag|

    page=tag.locals.page
    segments=[]
    title=""
    title= tag.attr['title'] if tag.attr['title']
    while page.parent
      if page.id==tag.locals.page.id
        segments << "<li>#{page.title}</li>"
      else
        segments << "<li><a href=\"/#{page.full_url}\">#{page.title}</a></li>"
      end
      page=page.parent
    end

    ret=<<EOF
    <ul id="breadcrumbs" class="menu-h">
    <li><a class="home" href="/">#{title}</a></li>
    <li>/</li>
    #{segments.reverse.join("<li>/</li>")}
    </ul>
EOF
    ret
  end

  desc %{breadcrumbs:news
  title="mytitle"
  newstitle="newstitle"
  }
  tag 'newsbreadcrumbs' do |tag|
    title=""
    title= tag.attr['title'] if tag.attr['title']
    newstitle=""
    newstitle= tag.attr['newstitle'] if tag.attr['newstitle']
    newsitem=nil
    newsitem= NewsItem.find(tag.attr['sid'].to_i) if tag.attr['sid']

    ret=<<EOF
    <ul id="breadcrumbs" class="menu-h">
    <li><a class="home" href="/">#{title}</a></li>
    <li>/</li>
    <li><a href="#{url_for(:action=>"index", :controller=>"news")}">#{newstitle}</a></li>
    <li>/</li>
    <li>#{newsitem.title if newsitem}</li>
    </ul>
EOF
    ret
  end

  desc %{Модуль заказов...}
  tag 'ordersform' do |tag|
    ret=<<EOF
        <script type=\"text/javascript\" src=\"/javascripts/orders.js\"></script>
        <script type=\"text/javascript\">
        window.addEvent('domready',function(){
          new OrdersForms({getform:'#{url_for(:action=>"get_form", :controller=>"order_send")}', sendform:'#{url_for(:action=>"send_order", :controller=>"order_send")}'});
        });
        </script>
EOF
    orders=Order.find(:all)
    if orders.length>0
      orders.each_index do |index|
        order=orders[index]
        ret+=<<EOF
        <div class="subcolumns #{"last" if index+1==orders.length}">
          <div class="c33l">
            <div class="subcl"><img alt="#{order.name}" src="#{order.image_url}"/></div>
          </div>
          <div class="c66r">
            <div class="subcr">
            <table class="full null-table">
              <tbody><tr>
                <td class="w-35">
                <h3>#{order.name}</h3>
                #{order.options}
                </td>
                <td class="w-65 a-right">
                Стоимость: <big class="cost">#{order.cash}</big>
                <span class="rub">Руб.</span>
                <div class="container">
                  <a id=\"buylink_#{order.id}\" class="buy f-right" href="#">Заказать</a>
                </div>
                </td>
              </tr>
            </tbody></table>
            </div>
          </div>
        </div>
EOF
      end
    end
    ret
  end

  desc %{Копирайты...}
  tag 'copyright' do |tag|
    title=""
    title=tag.attr['title'] if tag.attr['title']
    text=""
    text=tag.attr['text'] if tag.attr['text']

    ret=<<EOF
    <span class="copyright"><span class="bold">Copyright #{Time.now.year}. #{title}</span> #{text}</span>
EOF
    ret
  end

  desc %{Бланк обратной связи}
  tag 'contactform' do |tag|
    ret=<<EOF
        <script type=\"text/javascript\" src=\"/javascripts/contacts.js\"></script>
        <script type=\"text/javascript\">
        window.addEvent('domready',function(){
          new ContactsForms({getform:'#{url_for(:action=>"get_form", :controller=>"contacts")}', sendform:'#{url_for(:action=>"send_contact", :controller=>"contacts")}'});
        });
        </script>
        <div class="container">
          <p>
             Вы также можете задать нам интересующий Вас вопрос через
             <a class="cont" href="#{url_for(:action=>"get_form", :controller=>"contacts")}">Форму обратной связи</a>
          </p>
        </div>
EOF
  end

  tag 'block_template' do |tag|
    tag.expand
  end
  tag 'region' do |tag|
    result=""
    #Ищем блоки для данного региона на данной странице
    attr = tag.attr.symbolize_keys
    region = PageRegion.new(attr, tag.globals.page)
    region.blocks.each_with_index do |block, index|
      result += "<a2m:block id=\"#{block.id}\" block_index=\"#{index}\" />"
    end
    result=tag.globals.page.parse(result)
  end

  tag 'block' do |tag|
    attr = tag.attr.symbolize_keys
    block = Pageblock.find_by_id(attr[:id])
    tag.locals.block=block
    ext = block.blocktype unless block.blank?
    ext = "#{ext.split('_').map{|name| name.capitalize}.join}Extension".constantize.block_engine
    tag.locals.engine = ext.new(block, tag, attr[:block_index].to_i+1)

    if tag.locals.block.template.blank?
      result =<<EOT
<a2m:block_template>
<div class="user-block-<a2m:index /><a2m:css_prefix />">
<a2m:content />
</div>
</a2m:block_template>
EOT
    else
      result = tag.locals.block.template
    end
    result=tag.globals.page.parse(result)
    #
  end

  tag 'geophones' do |tag|
   result = ""

    g = get_geo_ip(request.env['REMOTE_ADDR'])
    
    cityes = get_cityes_hash
    active_city = cityes["saratov"]
    unless g.blank?
      tmp_active = cityes[g[7].downcase]
      active_city = tmp_active unless tmp_active==nil
    end
    result +=<<EOF
<a href="#" class="pseudo">Телефон в #{active_city[:name]}:</a> <span class="code">(#{active_city[:code]})</span> <span class="number">#{active_city[:number]}</span>
EOF
    
    result
  end

  tag 'all_phones' do |tag|
    result = ""
    result +=<<EOF
<div id="all_phones" class="modal hidden"><div class="content">
<div class="container"><h1 style="position: absolute; top: 24px;">Филиалы</h1><a class="icon cancel f-right" href="#">Закрыть окно</a></div>
<hr/>
<ul class="select-phone">
EOF
    
    get_cityes_hash.each_value do |hitem|
      result +=<<EOF
      <li><strong>Телефон в #{hitem[:name]}</strong> <span class="this"><span class="code">(#{hitem[:code]})</span> <span class="number">#{hitem[:number]}</span></span></li>
EOF
    end

    result +=<<EOF
</ul></div></div>
EOF
  end

  private
  def get_geo_ip(ip_addr="")
    geo =  GeoIP.new("#{RAILS_ROOT}/public/GeoLiteCity.dat")
    geo.city(ip_addr);
  end

  def get_cityes_hash
    {
      "saratov"=>{
        :name=>"Саратове",
        :code=>"8452",
        :number=>"39-00-93"
      },
      "samara"=>{
        :name=>"Самаре",
        :code=>"846",
        :number=>"336-63-62"
      },
      "volgograd"=>{
        :name=>"Волгограде",
        :code=>"8442",
        :number=>"97-45-88"
      },
      "penza"=>{
        :name=>"Пензе",
        :code=>"8412",
        :number=>"26-05-28"
      },
    }
  end
end
