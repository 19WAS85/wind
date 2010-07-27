require 'hurricane'

at_start do
	if not Widget[:title => 'Wordpress Importer']
		widget = Widget.new
		widget.title = 'Wordpress Importer'
		widget.content = '<form method="post" action="wordpress-importer" enctype="multipart/form-data"><input type="file" name="wordpress_file" placeholder="Wordpress file to import..."/><button type="submit">Go</button></form>'
		widget.admin = true
		widget.order = 1000
		widget.save
	end
end

post '/wordpress-importer' do
  if_logged do
	 to_wind params[:wordpress_file][:tempfile]
  end
  go_home
end

def to_wind(file)	
	blog = Hurricane::Parse.from(file)

	$settings.name = blog.title
	$settings.title = blog.description	
	$settings.save	
	
	blog.posts.each {|imported_post|
		post = Post.new
		post.title = imported_post.title		
		post.text = imported_post.description
		post.date = imported_post.created_at
		post.link = imported_post.link
		post.save
	}
end