# To change this template, choose Tools | Templates
# and open the template in the editor.

module PublicationPageblockExtend
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      include InstanceMethods

      has_many :publicationblocks
      has_many :publicationgroups, :through => :publicationblocks

      attr_accessor :publication_tag, :page_number
    end
  end

  module ClassMethods

  end

  module InstanceMethods

  end
end
