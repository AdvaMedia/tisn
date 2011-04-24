require 'test_helper'
require "yaml"

class CoreTests < ActiveSupport::TestCase
  test 'associations' do
    
    pages=Page.find(:all)
    templates=Template.find(:all)

    assert(pages.length==2, "pages_failure")
    assert(templates.length==2, "templates_failure")
    assert_not_nil(pages[0].page_parts)

    pages[0].page_parts<<PagePart.new(:name=>"corepart")
    pages[0].save

    pages=Page.find(:all)

    pages[0].page_parts.each do |part|
      puts part.name
    end

    assert_not_nil(pages[0].children)
  end

  test "template_stack_test" do
    
  end

  test "regex_test" do
    @tag_prefix="a2m"
    templates=Template.find(:all)
    templates[1].defined_parts('testajax').each do |tag|
      puts "tag- #{tag}"
    end
  end

end
