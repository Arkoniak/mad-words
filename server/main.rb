root = ::File.dirname(__FILE__)

require 'sinatra/base'

require 'json'
require 'yaml'
require ::File.join(root, 'mad_words_generator')

class App < Sinatra::Base
  
  configure :production, :development do
    set :port, 1617  # Не работает, кстати, так как оверрайдю
    
    mwg = MadWordsGenerator.new
    set :mwg, mwg
  end
end

require ::File.join(root, '/app/helpers')
require ::File.join(root, '/app/routes')
