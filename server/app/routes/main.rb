require 'json'

class App < Sinatra::Base
  before do
    @mwg = settings.mwg
  end

  get '/' do
    content_type :json, :charset => 'utf-8'
    length = params['length'].to_i
    length = length > 0 ? length : 1
    JSON.generate(@mwg.generaten length)
  end
end
