class PageblockObserver < ActiveRecord::Observer

  def before_update(model)
    reinit_pages(model) unless model.filter.blank?
  end

  def after_create(model)
    add_css_to_extend_file(model.css_text) unless model.css_text.blank?
    reinit_pages(model) unless model.filter.blank?
  end
  def after_update(model)
    reinitialize_file
  end
  def after_destroy(model)
    reinitialize_file
  end

  private
  def add_css_to_extend_file(csstext)
    trypath = File.join(RAILS_ROOT,"public","stylesheets","ext_blocks.css")
    File.open(trypath, 'a+') {|f| f.write("\r\n#{csstext}\r\n") }
  end

  def reinitialize_file
    trypath = File.join(RAILS_ROOT,"public","stylesheets","ext_blocks.css")
    File.delete(trypath) if  File.exist?(trypath)
    Pageblock.all.each do |pit|
      #TODO добавить возможность обновлять css
      add_css_to_extend_file(pit.css_text) unless pit.css_text.blank?
    end
  end

  def reinit_pages(model)
    model.pages=[]
    arr=model.filter.split("\r\n")
    arr.each do |fstr|
      model.pages+=Page.all(:conditions=>["full_url #{"not " unless model.filter_type}like :url",{:url=>fstr}])
    end
    model.pages = model.pages.uniq unless model.pages.blank?
  end

end
