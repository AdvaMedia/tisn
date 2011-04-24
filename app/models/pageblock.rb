# To change this template, choose Tools | Templates
# and open the template in the editor.

class Pageblock < ActiveRecord::Base
  has_and_belongs_to_many :pages

  def engine
    "#{blocktype.split('_').map{|name| name.capitalize}.join}Extension".constantize.block_engine
  end
end
