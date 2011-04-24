class RenameTemplatesTable < ActiveRecord::Migration
  def self.up
    #rename_table :templates, :sitetemplates
    #rename_column :pages, :template_id, :sitetemplate_id
  end

  def self.down
    #rename_table :sitetemplates, :templates
    #rename_column :pages, :sitetemplate_id, :template_id
  end
end
