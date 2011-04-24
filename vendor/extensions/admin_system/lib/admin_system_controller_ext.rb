# To change this template, choose Tools | Templates
# and open the template in the editor.

class AdminSystemControllerExt < ApplicationController
  include AuthenticatedSystem
  before_filter :admin_login_required, :except=>:login
end
