# To change this template, choose Tools | Templates
# and open the template in the editor.

class AdminExtController < ApplicationController
  include LoginSystem
  prepend_before_filter :authorize, :adminuser
  
end
