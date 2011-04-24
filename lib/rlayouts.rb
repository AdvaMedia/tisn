# To change this template, choose Tools | Templates
# and open the template in the editor.

module Rlayouts
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def r_layout(name=nil, options={}, &block)
      raise ArgumentError, "A layout name or block is required!" unless name || block
      write_inheritable_attribute 'r_layout', name || block
      before_filter :set_r_layout
      layout 'extending', options
    end
  end

  def set_r_layout
    @r_layout = self.class.read_inheritable_attribute 'r_layout'
    @r_layout = @r_layout.call(self) if @r_layout.is_a? Proc
  end
end
