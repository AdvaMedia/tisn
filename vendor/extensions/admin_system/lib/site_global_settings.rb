# To change this template, choose Tools | Templates
# and open the template in the editor.

class SiteGlobalSettings

  attr_accessor :name, :mail, :rootpage, :error_403, :error_404

  def initialize
    @name = A2mConfiguration.get_value(SettingsExtension.extension_name, "name", "advamedia.ru")
    @mail = A2mConfiguration.get_value(SettingsExtension.extension_name, "mail", "postmaster@#{@name}")
    @rootpage = A2mConfiguration.get_value(SettingsExtension.extension_name, "rootpage", "/")
    @error_403 = A2mConfiguration.get_value(SettingsExtension.extension_name, "error_403", "/403")
    @error_404 = A2mConfiguration.get_value(SettingsExtension.extension_name, "error_404", "/403")
  end

  def save
    A2mConfiguration.set_value(SettingsExtension.extension_name, "name", @name)
    A2mConfiguration.set_value(SettingsExtension.extension_name, "mail", @mail)
    A2mConfiguration.set_value(SettingsExtension.extension_name, "rootpage", @rootpage)
    A2mConfiguration.set_value(SettingsExtension.extension_name, "error_403", @error_403)
    A2mConfiguration.set_value(SettingsExtension.extension_name, "error_404", @error_404)
  end

  def update_attributes(attr={})
    attr.each do |at|
      A2mConfiguration.set_value(SettingsExtension.extension_name, at[0], at[1])
    end
  end
end
