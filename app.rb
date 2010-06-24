require 'rubygems'
require 'sinatra'
require 'config'
require 'lib/db'

configure do
  enable :sessions
end

helpers do
  require 'lib/helpers'
end

get '/' do
  @posts = Post.filter.order(:date.desc)
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  if auth? params[:code]
    login
    go_home
  else
    notice 'Invalid credentials!'
    erb :login
  end
end

get '/logout' do
  if_logged do
    login false
    go_home
  end
end

get '/post/new' do
  if_logged do
    @post = Post.new
    erb :post
  end
end

post '/post' do
  if_logged do
    post = Post[params[:id]] || Post.new
    post.title = params[:title]
    post.text = params[:text]
    post.date = Time.now unless post.id
    post.save
    go_home
  end
end

get '/post/:id' do
  if_logged do
    @post = Post[params[:id]]
    erb :post
  end
end

delete '/post/:id' do
  if_logged do
    Post[params[:id]].delete
    go_home
  end
end