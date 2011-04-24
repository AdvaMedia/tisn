# To change this template, choose Tools | Templates
# and open the template in the editor.

module PublicationPageExtend
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      include InstanceMethods

      has_many :publicationpages
      has_many :publicationgroups, :through => :publicationpages

      attr_accessor :publication_tag, :page_number
    end
  end

  module ClassMethods

  end

  module InstanceMethods

  end
end
