require 'test_helper'
require "yaml"

class ModulsTest < ActiveSupport::TestCase

  test 'moduls_first' do
    puts Page.find(:all).inspect
  end
end
