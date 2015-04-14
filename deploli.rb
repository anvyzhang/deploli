APP_PATH = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(APP_PATH)
require 'rubygems'
require 'sinatra'
require 'config'
set :public_folder, "#{APP_PATH}/public"

get '/' do
  erb :index
end

get '/submit' do
  lolis_path = "#{APP_PATH}/lolis/#{Time.now.localtime.strftime("%Y%m%d")}"
  app, env = params[:loli].split("__")
  cmd = APPS[app]['envs'][env][params[:op]]
  if cmd
    op_file = "#{lolis_path}/#{params[:loli]}.op"
    `touch #{op_file}`
    `echo #{Time.now.localtime.strftime("%Y%m%d%H%M%S")}: #{params[:op]} >> #{op_file}`
    @detail = `#{cmd}`
    `echo "#{@detail}" >> #{op_file}`
    @detail = @detail.gsub("\n", "<br/>")
    @msg = "Submit #{params[:op].upcase} success!"
  else
    @msg = "Submit #{params[:op].upcase} failed!"
  end
erb :msg
end
