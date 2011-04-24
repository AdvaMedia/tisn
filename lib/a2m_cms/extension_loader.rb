# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'annotatable'
require 'simpleton'
require 'a2m_cms/extension'

module A2mCms
  class ExtensionLoader
    include Simpleton

    attr_accessor :initializer, :extensions, :tags_classes, :extension_groups
    
    def initialize
      self.extensions = []
      self.tags_classes=[]
      self.extension_groups={
        "home"=>["Главная",[],0],
        "content"=>["Контент",[],1],
        "users"=>["Пользователи",[],2],
        "settings"=>["Настройки",[],3],
        "mail"=>["Письма",[],4],
        "analytics"=>["Статистика",[],5],
        "trash"=>["Корзина",[],6]
      }
    end

    def self.init_plugins
      self.extensions=A2mCms::Extension.registered_plugins
    end

    def self.add_tag_class(array_of_classes=[])
      unless array_of_classes.length==0
        array_of_classes.each do |tagclass|
          self.tags_classes << tagclass
        end
      end
    end

    def self.grouped_extensions
      ret=A2mCms::ExtensionLoader.extension_groups
      A2mCms::ExtensionLoader.extensions.to_a.reject {|ext| !ext.visible}.each do |ext|
        if ret.key?(ext.extension_group)
          ret[ext.extension_group][1]<<ext unless ret[ext.extension_group][1].include?(ext)
        end
      end
      ret
    end

    def self.extensions_to_install
      ret=A2mCms::ExtensionLoader.extension_groups
      A2mCms::ExtensionLoader.extensions.to_a.each do |ext|
        if ret.key?(ext.extension_group)
          ret[ext.extension_group][1]<<ext unless ret[ext.extension_group][1].include?(ext)
        end
      end
      ret
    end
  end
end
