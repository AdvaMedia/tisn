# To change this template, choose Tools | Templates
# and open the template in the editor.

module PagedBlockExtend
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      include InstanceMethods

      has_and_belongs_to_many :tabgroups
    end
  end

  module ClassMethods

  end

  module InstanceMethods

  end
end
