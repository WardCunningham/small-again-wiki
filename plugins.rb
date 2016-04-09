require './markdown'

def resolve text
  text.gsub(/(\[\[(.*?)\]\])/) { | link | "<a href=\"/view/#{slug $2}\">#{$2}</a>"}
end

def slug title
  title.gsub(/\s/,'-').gsub(/[^A-Za-z0-9-]/, '').downcase
end

def plugin item
  case item['type']

    when 'image'
      "<p><img src=\"#{item['url']}\"><br>#{item['caption']||item['text']}</p>"

    when 'markdown'
      "<p>#{resolve mkdown item['text']}<p>"

    when 'pagefold'
      "<p style=\"color: #ccc\">— #{item['text']||''} —</p>"

    else
      "<p>#{resolve item['text']||item['type']}</p>"
  end
end