# To change this template, choose Tools | Templates
# and open the template in the editor.

class PageRegion
  attr_accessor :name, :title, :page_filter
  def initialize(region, in_page = nil)
    self.name = region["name"]||region[:name]
    self.title = region["title"]
    self.page_filter = in_page
  end

  def blocks
    result=[]
    result = Pageblock.all(:conditions=>{:region_name=>name})
    result = result.select{|bl| bl.pages.include?(page_filter)} unless page_filter.blank?
    result = result.sort{|x,y| x.weight <=> y.weight}
    result
  end
end
