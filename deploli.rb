APP_PATH = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(APP_PATH)
require 'rubygems'
require 'sinatra'
require 'config'
require 'libs/term_color'
set :public_folder, "#{APP_PATH}/public"

get '/' do
  erb :index
end

get '/submit' do
  lolis_path = "#{APP_PATH}/lolis/#{Time.now.localtime.strftime("%Y%m")}"
  app, env = params[:loli].split("__")
  cmd = APPS[app]['envs'][env][params[:op]]
  if cmd
    op_file = "#{lolis_path}/#{params[:loli]}.op"
    `mkdir -p #{lolis_path}`
    `touch "#{op_file}"`
    `echo "#{Time.now.localtime.strftime("%Y%m%d%H%M%S")}: #{params[:op]}" >> #{op_file}`
    `nohup bash -c "#{cmd} > #{op_file} 2>&1 &" &`
    redirect "/query?loli=#{params[:loli]}"
  else
    @msg = "Submit #{params[:op].upcase} failed!"
  end
  erb :msg
end

get '/query' do
  erb :msg
end

get '/sub_status' do
  lolis_path = "#{APP_PATH}/lolis/#{Time.now.localtime.strftime("%Y%m")}"
  app, env = params[:loli].split("__")
  envs = APPS[app]['envs'][env]
  if envs.count < 1
    redir ''
  end
  op_file = "#{lolis_path}/#{params[:loli]}.op"
  f = File.open(op_file, "r")
  detail = f.readlines.join
  f.close
  escape_to_html(detail.to_s)
end
