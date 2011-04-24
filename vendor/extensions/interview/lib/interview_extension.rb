class InterviewExtension < A2mCms::Extension
  url "http://advamedia.ru"
  extension_name "interview"
  title "Опросы"
  version '0.1'
  root File.dirname(__FILE__)+'/../'
  extension_group "content"
  visible true
  is_material false
  is_block true
  block_engine InterviewBlockEngine
  #page_engine  PageEngine
  index_controller "Interview"

  admin_index "admin/#{extension_group}/interview"

  define_routes do |map|
    #map.connect 'url', :controller => 'Controller', :action => 'action', :conditions=>{ :method=>:post}
    begin
      map.with_options :controller=>"InterviewAdmin" do |ind_cont|
        ind_cont.connect "/#{admin_index}", :action=>"index"
        ind_cont.connect "/#{admin_index}/new", :action=>"new"
        ind_cont.connect "/#{admin_index}/create", :action=>"create"
        ind_cont.connect "/#{admin_index}/:id/edit", :action=>"edit"
        ind_cont.connect "/#{admin_index}/:id/save", :action=>"save"
        ind_cont.connect "/#{admin_index}/:id/delete", :action=>"delete"
        ind_cont.connect "/#{admin_index}/for_block/:id", :action=>"set_to_block"
      end
      map.with_options :controller=>"InterviewVariants" do |ind_cont|
        ind_cont.connect "/#{admin_index}/items", :action=>"index"
        ind_cont.connect "/#{admin_index}/:id/items", :action=>"show"
        ind_cont.connect "/#{admin_index}/:id/new_item", :action=>"new"
        ind_cont.connect "/#{admin_index}/:id/create_item", :action=>"create"
        ind_cont.connect "/#{admin_index}/:id/item/:tid/edit", :action=>"edit"
        ind_cont.connect "/#{admin_index}/:id/item/:tid/save", :action=>"save"
        ind_cont.connect "/#{admin_index}/:id/item/:tid/delete", :action=>"delete"
      end
      #vopages = Page.all(:conditions=>{:contenttype=>InterviewExtension.extension_name})
      #init_pages_routes(map)
      init_interview_pages(map)
    rescue Exception=>ex
    end
  end

  def init_interview_pages(map)
    #Находим страницы, на которых расположен блок с интервью
    Interviewblock.all.each do |iblock|
      iblock.pageblock.pages.each do |ipage|
        map.with_options :url=>ipage.full_url do |pers|
          pers.with_options :controller=>index_controller do |cl|
	    cl.connect "#{ipage.full_url=="/" ? "/root":ipage.full_url}-vote", :action=>"vote"           
            Pagealias.all(:conditions=>{:page_id=>ipage.id}).each do |mmetpage|
               cl.connect "#{mmetpage.url=="/" ? "/root":mmetpage.url}-vote", :action=>"vote" 
              end
          end
        end
      end
    end
  end


  def add_to_route(routarr, page_url)
    routarr.with_options :url=>page_url do |pers|
      pers.with_options :controller=>index_controller do |cl|
        cl.connect "#{page_url}-vote", :action=>"vote"
      end
    end
  end

  

  def foo; 1 end
end

Pageblock.send :include, InterviewPageblockExtend
