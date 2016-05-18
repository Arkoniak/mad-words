$: << File.expand_path('../', __FILE__)
require 'main'

def start_app
  Rack::Builder.app do
    cookie_settings = {
      :expire_after => 86400*30, # in seconds 30 days
      :secret => ENV["COOKIE_KEY"] || '324bc67cf122083a82b67486ba591298b61853d08985e44f564780547ee82b4b',
      :httponly => true,
      # :secure => true
    }

    #AES encryption of cookies
    use Rack::Session::Cookie, cookie_settings

    run App.new
  end
end
