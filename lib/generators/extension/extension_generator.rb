# To change this template, choose Tools | Templates
# and open the template in the editor.

class ExtensionGenerator < Rails::Generator::NamedBase
  default_options :with_test_unit => false

  attr_reader :extension_path, :extension_file_name

  def initialize(runtime_args, runtime_options = {})
    super
    @extension_file_name = "#{file_name}_extension"
    @extension_path = "vendor/extensions/#{file_name}"
  end

  def manifest
    record do |m|
      m.directory "#{extension_path}/app/controllers"
      m.directory "#{extension_path}/app/helpers"
      m.directory "#{extension_path}/app/models"
      m.directory "#{extension_path}/app/views"
      m.directory "#{extension_path}/db/migrate"
      m.directory "#{extension_path}/lib"
      m.directory "#{extension_path}/tasks"

      m.template 'README', "#{extension_path}/README"
      m.template 'extension.rb', "#{extension_path}/lib/#{extension_file_name}.rb"
      m.template 'migrate.rb', "#{extension_path}/db/migrate/001_create_#{file_name}_extension_tables.rb"
      m.template 'init.rb', "#{extension_path}/init.rb"
    end
  end

  def class_name
    super.capitalize.gsub(' ', '') + 'Extension'
  end

  def extension_name
    class_name.capitalize+'Extension'
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("--with-test-unit",
      "Use Test::Unit for this extension instead of RSpec") { |v| options[:with_test_unit] = v }
  end

end
