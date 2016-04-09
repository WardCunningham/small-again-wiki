require 'json'
require 'sinatra'

helpers do

  def show slug
    begin
      render JSON.parse File.read path slug
    rescue
      status 404
      "File Not Found"
    end
  end

  def path slug
    "../../.wiki/pages/#{slug}"
  end

  def render page
    html = [header(page['title'])]
    page['story'].each do | item |
      html << "<p>#{resolve item['text']||item['type']}</p>"
    end
    html.join "\n"
  end

  def header title
    "<h1><a href=\"/view/#{slug title}\"><img src=\"/favicon.png\" width=32></a> #{title}</h1>"
  end

  def resolve text
    text.gsub(/(\[\[(.*?)\]\])/) { | link | "<a href=\"/view/#{slug $2}\">#{$2}</a>"}
  end

  def slug title
    title.gsub(/\s/,'-').gsub(/[^A-Za-z0-9-]/, '').downcase
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