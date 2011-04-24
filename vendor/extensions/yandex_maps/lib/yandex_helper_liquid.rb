require 'liquid'

module TextFilter
  include FileColumnHelper

  def get_image_path(input, ver)
  	input.image_url(ver)
  end
end

Liquid::Template.register_filter(TextFilter)
