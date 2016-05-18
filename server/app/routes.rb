root = ::File.dirname(__FILE__)

Dir[root + '/routes/**'].each do |route|
  require route
end
