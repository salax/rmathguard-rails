begin
  require 'rmathguard'
rescue LoadError
  puts "Could not load rmathguard gem."
  exit
end

require 'rmathguard_rails'
