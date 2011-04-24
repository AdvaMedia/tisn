require 'annotatable'
require 'simpleton'
require 'rake'
module A2mCms
  class Extension
    include Simpleton
    include Annotatable

    @registered_plugins = []

    annotate :version, :description, :url, :extension_name, :extension_group, :root, :image_src, :visible
    annotate :title, :admin_index, :is_material, :index_controller
    annotate :is_block, :block_engine, :page_engine

    def self.inherited(child)
      Extension.registered_plugins << child
    end

    def migrated?
      migrator.new(:up, migrations_path).pending_migrations.empty?
    end

    def migrations_path
      File.join(self.root, 'db', 'migrate')
    end

    def migrator
      unless @migrator
        extension = self
        @migrator = Class.new(ExtensionMigrator){ self.extension = extension }
      end
      @migrator
    end

    #    def self.menu_extensions
    #      ret=Hash.new
    #      #
    #      registered_plugins.to_a.reject {|ext| !ext.visible}.each do |ext|
    #        if !ret.key?(ext.extension_group)
    #          ret[ext.extension_group]=[]
    #        end
    #        ret[ext.extension_group]<<ext
    #      end
    #      ret
    #    end

    def install
      t=Rake::Task["a2m:extensions:#{extension_name}:install"]
      t.execute
    end
    

    class << self
      attr_reader :registered_plugins

      def define_routes(&block)
        route_definitions << block
      end

      def route_definitions
        @route_definitions ||= []
      end

      def init_app_paths(paths=[])
        paths.each do |dir|
          path = File.join(File.dirname(__FILE__), 'app', dir)
          $LOAD_PATH << path
          ActiveSupport::Dependencies.load_paths << path
          ActiveSupport::Dependencies.load_once_paths.delete(path)
        end
      end

      def init_pages_routes(map)
        begin
          pages=Page.find_all_by_contenttype(extension_name)
          unless pages.blank?
            pages.each do |matpage|
              add_to_route(map, matpage.full_url)
              Pagealias.all(:conditions=>{:page_id=>matpage.id}).each do |mmetpage|
                add_to_route(map, mmetpage.url)
              end
            end
          end
        rescue Exception=>ex
        end
      end

    end
  end
end