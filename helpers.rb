require 'RedCloth'

def partial(view)
  erb :"_#{view}", :layout => false
end

def go_home
  redirect '/'
end

def message(text)
  @message = text
end

def auth?(code)
  code == $settings.code
end

def login(log = true)
  session[:logged] = log
end

def logged?
  session[:logged]
end

def if_logged
  if logged?
    yield if block_given?
  else
    go_home
  end
end

def env
  request['ENV']
end

def host
  "http://#{env['HTTP_HOST']}"
end

def path
  "#{host}#{env['REQUEST_PATH']}"
end

def to_link(title)
  title.gsub(' ', '-').urlize
end

def textile(text)
  RedCloth.new(text).to_html
end

def today
  Date.today
end

def date(the_date)
  the_date.strftime '%Y-%m-%d'
end

def edit_link(path, id)
  " <a class='edit' href='/#{path}/#{id}'>[Edit]</a>" if logged?
end

def next_page
  count = Post.count
  if params[:page]
    page = params[:page].to_i
    if count > page * PAGE_SIZE
      page + 1
    end
  elsif count > PAGE_SIZE
    2
  end
end

def feed_url
  feed = $settings.feed
  if feed.nil? or feed.empty?
    '/feed'
  else
    feed
  end
end

def wind_link
  'http://github.com/wagnerandrade/wind'
end

def style
  if File.exist? 'public/custom/style.css'
    '/custom/style.css'
  else
    '/style.css'
  end
end

def feed(posts)
  builder do |xml|
    xml.instruct! :xml, :version => '1.0'
    xml.rss :version => "2.0" do
      xml.channel do
        xml.title $settings.name
        xml.description $settings.title
        xml.link host
        posts.each do |post|
          xml.item do
            xml.title post.title
            xml.link "#{host}/#{post.link}"
            xml.description textile(post.text)
            xml.pubDate post.date.rfc822()
            xml.guid "#{host}/#{post.link}"
          end
        end
      end
    end
  end
end