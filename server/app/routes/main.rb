require 'json'

class App < Sinatra::Base
  before do
    @mwg = settings.mwg
  end

  get '/' do
    # content_type :json
    # JSON.generate("some word")
    @mwg.generate
  end
end
