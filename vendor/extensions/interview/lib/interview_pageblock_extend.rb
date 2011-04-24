# To change this template, choose Tools | Templates
# and open the template in the editor.

module InterviewPageblockExtend
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      include InstanceMethods

      has_many :interviewblocks
      has_many :interviews, :through => :interviewblocks
    end
  end

  module ClassMethods

  end

  module InstanceMethods

  end
end
