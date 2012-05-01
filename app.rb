require 'bundler/setup'
require 'sinatra'
require 'omniauth-oauth2'
require 'omniauth-google-oauth2'
require 'pry'

use OmniAuth::Builder do
  config = YAML.load_file 'config/config.yml'
  provider :google_oauth2, config['identifier'], config['secret']
end

use Rack::Session::Cookie, secret: 'abcdefg'
enable :sessions

get '/' do
  %Q|<a href='/auth/google_oauth2'>Sign in with Google</a>|
end

get '/auth/:name/callback' do
  @auth = request.env['omniauth.auth']
  @auth.inspect
end
