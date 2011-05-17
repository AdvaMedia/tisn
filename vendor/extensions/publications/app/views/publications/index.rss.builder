xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @page.title
    xml.description ""
    xml.link  "http://#{request.host}#{@page.full_url}"

    for item in @items
      xml.item do
        xml.title item.title
        xml.description item.descriptions
        xml.pubDate item.created_at.to_s(:rfc822)
        xml.link "http://#{request.host}#{@page.full_url}/#{item.tag}"
      end
    end
  end
end
