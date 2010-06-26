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
  code == $blog.code
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

def textile(text)
  RedCloth.new(text).to_html
end

def today
  Date.today
end

def date(the_date)
  the_date.strftime '%Y-%m-%d'
end

def universal(date)
  date.rfc822
end

def edit_link(path, id)
  " (<a href='/#{path}/#{id}' class='edit'>Edit</a>)" if logged?
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