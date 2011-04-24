Dir.glob(File.dirname(__FILE__) + "/../../vendor/extensions/**/tasks/*.rake").each do |rake_file|
  import rake_file
end
