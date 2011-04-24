# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def tags_link(modul)
    link_to("Тэги", {:action=>"tags_for", :controller=>"Admin::TaggbleAdm", :modul=>modul}, {:id=>"help_tags_for#{modul}", :class=>"menuitem"})
  end

  def table(collection, headers, options = {}, &proc)
    options.reverse_merge!({
        :placeholder  => 'Nothing to display',
        :caption      => nil,
        :summary      => nil,
        :footer       => ''
      })
    unless collection.blank?
      summary = options[:summary] || "A list of #{collection.first.class.to_s.pluralize}"
      output = "<table summary=\"#{summary}\" #{add_tags_options(options)}>\n"
      output << content_tag('caption', options[:caption]) if options[:caption]
      #output << "\t<caption>#{options[:caption]}</caption>\n" if options[:caption]
      output << content_tag('thead', content_tag('tr', headers.collect { |h| "\n\t" + content_tag('th', h) }))
      #output << "<tfoot><tr>" + content_tag('th', options[:footer], :colspan => headers.size) + "</tr></tfoot>\n" if options[:footer]
      output << "<tbody>\n"
      concat(output, proc.binding)
      collection.each do |row|
        proc.call(row, cycle('odd', 'even'))
      end
      concat("</tbody>\n</table>\n", proc.binding)
    end
  end

  def add_tags_options(options)
    ret=""
    [:style, :class].each do |item|
      ret+="#{item}=\"#{options[item]}\" " if options[item]
    end
    ret
  end


end
