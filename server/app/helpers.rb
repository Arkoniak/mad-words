root = ::File.dirname(__FILE__)

Dir[root + '/helpers/**'].each do |helper|
  require helper
end
