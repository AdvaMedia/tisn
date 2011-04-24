# To change this template, choose Tools | Templates
# and open the template in the editor.

module PublicationListTags
  unloadable
  include Taggable
  #attr = tag.attr.symbolize_keys

  [:publication_getegory].each do |cat_prefix|
    tag "#{cat_prefix}" do |tag|
      if tag.globals.page.publicationgroups.length>0
        tag.locals.publication_category = tag.globals.page.publicationgroups.first
        tag.expand if tag.locals.publication_category
      end
    end

    [:name, :tag].each do |action|
      tag "#{cat_prefix}:#{action}" do |tag|
        tag.locals.publication_category.send(action)
      end
    end

    tag "#{cat_prefix}:link" do |tag|
      result = "#"
      unless tag.locals.publication_category.publicationpages.first.page.blank?
        result = tag.locals.publication_category.publicationpages.first.page.full_url
      end
      result
    end
  end


  [:publicationlist].each do |prefix|
    tag "#{prefix}" do |tag|
      attr = tag.attr.symbolize_keys
      return_text = Rails.cache.fetch("Publications/publication_list_for-page#{tag.globals.page.id}-#{tag.globals.page.page_number}"){
        tag.locals.publications_per_page = attr[:count] || 5
        if tag.globals.page.publicationgroups.length>0
          tag.locals.publicationitems = tag.globals.page.publicationgroups.first.publicationitems.paginate(:page=>tag.globals.page.page_number, :per_page=>tag.locals.publications_per_page)
          tag.expand
        end
      }
      return_text
    end

    [:items].each do |itms|
      tag "#{prefix}:#{itms}" do |tag|
        result = []
        tag.locals.publicationitems.each_with_index do |item, i|
          tag.locals.publication_item = item
          result << tag.expand
        end
        result
      end

      #------

      [:item].each do |postfix|
        tag "#{prefix}:#{itms}:#{postfix}" do |tag|
          tag.expand
        end

        [:title, :descriptions, :content, :image_url, :tag].each do |action|
          tag "#{prefix}:#{itms}:#{postfix}:#{action}" do |tag|
            tag.locals.publication_item.send(action) unless tag.locals.publication_item.blank?
          end
        end

        tag "#{prefix}:#{itms}:#{postfix}:date" do |tag|
          attr = tag.attr.symbolize_keys
          dateformat=(attr[:format]||"%d-%m-%y").strip
          tag.locals.publication_item.created_at.strftime(dateformat) unless tag.locals.publication_item.blank?
        end

        tag "#{prefix}:#{itms}:#{postfix}:url" do |tag|
          "#{tag.globals.page.full_url}/#{tag.locals.publication_item.tag}"
        end
      end

      #------
    end

    [:pagination].each do |postfix|
      tag "#{prefix}:#{postfix}" do |tag|
        tag.expand if tag.locals.publicationitems.total_pages>1
      end

      [:pages].each do |p_pages|
        tag "#{prefix}:#{postfix}:#{p_pages}" do |tag|
          result = []
          tag.locals.publicationitems.total_pages.times do |ind|
            tag.locals.publication_p_page = ind+1
            result << tag.expand
          end
          result
        end
        
        tag "#{prefix}:#{postfix}:#{p_pages}:number" do |tag|
          tag.locals.publication_p_page
        end
        
        tag "#{prefix}:#{postfix}:#{p_pages}:class" do |tag|
          attr = tag.attr.symbolize_keys
          attr[:class] if tag.locals.publication_p_page == tag.locals.publicationitems.current_page
        end

        tag "#{prefix}:#{postfix}:#{p_pages}:link" do |tag|
          "#{tag.globals.page.full_url}/page-#{tag.locals.publication_p_page}"
        end
      end

      tag "#{prefix}:#{postfix}:first" do |tag|
        tag.expand if tag.locals.publicationitems.current_page > 1
      end

      tag "#{prefix}:#{postfix}:first:link" do |tag|
        "#{tag.globals.page.full_url}/page-#{tag.locals.publicationitems.current_page-1}"
      end

      tag "#{prefix}:#{postfix}:last" do |tag|
        tag.expand if tag.locals.publicationitems.current_page < tag.locals.publicationitems.total_pages
      end

      tag "#{prefix}:#{postfix}:last:link" do |tag|
        "#{tag.globals.page.full_url}/page-#{tag.locals.publicationitems.current_page+1}"
      end

    end
  end

  [:publication].each do |prefix|
    tag "#{prefix}" do |tag|
      attr = tag.attr.symbolize_keys
      tag.locals.publication_item = tag.globals.page.publication_tag if tag.globals.page.publication_tag
      result_text = Rails.cache.fetch("Publications/publication-#{tag.locals.publication_item.id}-for-page-#{tag.globals.page.id}"){
        tag.expand
      }
      result_text
    end

    [:title, :descriptions, :content, :image_url, :tag].each do |action|
      tag "#{prefix}:#{action}" do |tag|
        tag.locals.publication_item.send(action) unless tag.locals.publication_item.blank?
      end
    end
  end

  [:publication_block].each do |prefix|
    tag "#{prefix}" do |tag|
      result=""
      attr = tag.attr.symbolize_keys
      tag.locals.publication_block = Publicationblock.find_by_id(attr[:id]) unless attr[:id].blank?
      result = tag.globals.page.parse(tag.locals.publication_block.template)
      result
    end

    tag "#{prefix}:lastnew" do |tag|
      result=""
      tag.locals.last_new = tag.locals.publication_block.publicationgroup.publicationitems.first unless tag.locals.publication_block.publicationgroup.blank?
      unless tag.locals.last_new.blank?
        result +=<<EOF
<div class="entry"><img alt="#{tag.locals.last_new.title}" class="f-left" height="100" src="#{tag.locals.last_new.image_url}" width="170" />
<h3 class="entry-title"><a href="#{"#{tag.locals.last_new.publicationgroup.publicationpages.first.page.full_url}/#{tag.locals.last_new.tag}"}">#{tag.locals.last_new.title}</a></h3>
				<div class="publication-content">
					#{tag.locals.last_new.descriptions}
				</div>
			</div>
EOF
      end
    end

    [:publication_getegory].each do |cat_prefix|
      tag "#{prefix}:#{cat_prefix}" do |tag|
        unless tag.locals.publication_block.publicationgroup.blank?
          tag.locals.publication_category = tag.locals.publication_block.publicationgroup
          tag.expand if tag.locals.publication_category
        end
      end

      [:name, :tag].each do |action|
        tag "#{prefix}:#{cat_prefix}:#{action}" do |tag|
          tag.locals.publication_category.send(action)
        end
      end

      tag "#{prefix}:#{cat_prefix}:link" do |tag|
        result="#"
        if tag.locals.publication_category.publicationpages.length>0
          unless tag.locals.publication_category.publicationpages.first.page.blank?
            result = tag.locals.publication_category.publicationpages.first.page.full_url 
          end
        end
        result
      end
    end

    [:items].each do |postfix|
      tag "#{prefix}:#{postfix}" do |tag|
        attr = tag.attr.symbolize_keys
        publications_count = attr[:count] || 5
        result = []
        unless tag.locals.publication_block.publicationgroup.blank?
          tag.locals.publication_category = tag.locals.publication_block.publicationgroup
          tag.locals.publication_category.publicationitems[0..publications_count.to_i].each do |publication|
            tag.locals.publication_item = publication
            result << tag.expand
          end
        end
        result
      end
      [:title, :descriptions, :content, :image_url, :tag].each do |action|
        tag "#{prefix}:#{postfix}:#{action}" do |tag|
          tag.locals.publication_item.send(action) unless tag.locals.publication_item.blank?
        end
      end

      tag "#{prefix}:#{postfix}:date" do |tag|
        attr = tag.attr.symbolize_keys
        dateformat=(attr[:format]||"%d-%m-%y").strip
        tag.locals.publication_item.created_at.strftime(dateformat) unless tag.locals.publication_item.blank?
      end

      tag "#{prefix}:#{postfix}:url" do |tag|
        result = "#"
        unless tag.locals.publication_category.publicationpages.first.page.blank?
          result = "#{tag.locals.publication_category.publicationpages.first.page.full_url}/#{tag.locals.publication_item.tag}"
        end
      end
    end
  end
  
end
