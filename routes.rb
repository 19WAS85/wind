before do
  @widgets = Widget.filter.order(:order)
end

get '/' do
  @posts = Post.ordered
  @next_page = next_page
  erb :index
end

get '/page/:page' do
  @posts = Post.ordered params[:page]
  @next_page = next_page
  erb :index
end

get '/search' do
  @posts = Post.search params[:q]
  erb :index
end

get '/feed' do
  @posts = Post.ordered
  content_type 'xml'
  feed @posts
end

get '/login' do
  go_home if logged?
  erb :login
end

post '/login' do
  if auth? params[:code]
	login
	go_home
  else
	message 'Ops! Wrong code.'
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
	unless post.id
	  post.date = Time.now
	  post.link = to_link params[:title]
	end
	if params[:action] == 'save'
	  post.save
	  go_home
	elsif params[:action] == 'preview'
	  @posts = [] << post
	  erb :index
	end
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

get '/widget/new' do
  if_logged do
	@widget = Widget.new
	erb :widget
  end
end

post '/widget' do
  if_logged do
	widget = Widget[params[:id]] || Widget.new
	widget.title = params[:title]
	widget.content = params[:content]
	widget.order = params[:order]
	widget.save
	go_home
  end
end

get '/widget/:id' do
  if_logged do
	@widget = Widget[params[:id]]
	erb :widget
  end
end

delete '/widget/:id' do
  if_logged do
	Widget[params[:id]].delete
	go_home
  end
end

get '/settings' do
  if_logged do
	erb :settings
  end
end

post '/settings' do
  if_logged do
	if auth? params[:code]
	  $settings.name = params[:name]
	  $settings.title = params[:title]
	  $settings.code = params[:new_code] unless params[:new_code].empty?
	  $settings.feed = params[:feed]
	  $settings.footer = params[:footer]
	  $settings.tracker = params[:tracker]
	  $settings.save
	  go_home
	else
	  message 'Ops! Wrong code.'
	  erb :settings
	end
  end
end

get '/:link' do
  @posts = Post.with_link params[:link]
  @title = @posts.first.title
  @footer = $settings.footer
  erb :index
end