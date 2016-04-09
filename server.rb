require './plugins'
require 'json'
require 'sinatra'

helpers do

  def show slug
    render JSON.parse File.read path slug
  rescue
    status 404
    "File Not Found"
  end

  def path slug
    "../../.wiki/pages/#{slug}"
  end

  def render page
    [ header(page['title']), story(page['story']) ].flatten.join "\n"
  end

  def header title
    "<h1><a href=\"/view/#{slug title}\"><img src=\"/favicon.png\" width=32></a> #{title}</h1>"
  end

  def story items
    items.map {| item | plugin item}
  end

  def cors
    headers 'Access-Control-Allow-Origin' => "*" if request.env['HTTP_ORIGIN']
  end

end

get '/' do 
  redirect 'view/welcome-visitors'
end

get '/*.json' do | slug |
  cors
  send_file path slug
end

get '/*.html' do | slug |
  show slug
end

get '/view/*' do | slug |
  show slug
end