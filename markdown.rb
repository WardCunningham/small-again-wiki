# lineNumber = 0
# totalLines = 0

def hders line
  line = line.gsub(/^#+(.*)$/) { "<h3>#{$1}</h3>"} 
end

def emphs line
  line = line.gsub(/\*\*(\S.*?\S)\*\*/) {"<b>$1</b>"}
  line = line.gsub(/\_\_(\S.*?\S)\_\_/) {"<b>$1</b>"}
  line = line.gsub(/\*(\S.*?\S)\*/) {"<i>$1</i>"}
  line = line.gsub(/\_(\S.*?\S)\_/) {"<i>$1</i>"}
  line = line.gsub(/\*\*(\S)\*\*/) {"<b>$1</b>"}
  line = line.gsub(/\_\_(\S)\_\_/) {"<b>$1</b>"}
  line = line.gsub(/\*(\S)\*/) {"<i>$1</i>"}
  line = line.gsub(/\_(\S)\_/) {"<i>$1</i>"}
end

def lists line
#   line = line.replace /^ *[*-] +(\[[ x]\])(.*)$/, (line, box, content) ->
#     checked = if box == '[x]' then  ' checked' else ''
#     "<li><input type=checkbox data-line=#{lineNumber}#{checked}>#{content}</li>"
  line.gsub(/^ *[*-] +(.*)$/) {"<li>#{$1}</li>"}
end

# escape = (line) ->
#   line
#     .replace(/&/g, '&amp;')
#     .replace(/</g, '&lt;')
#     .replace(/>/g, '&gt;')

# code = (line) ->
#   styles = 'background:rgba(0,0,0,0.04);padding:0.2em 0.4em;border-radius:3px'
#   line.replace /`(\S.*?\S)`/g, "<code style=\"#{styles}\">$1</code>"

# breakLine = (line) ->
#   exp = /// (
#     [^>]+            # does not end with a tag
#     | <\/(i|b|code)> # or the tag is an inline tag (<i>, <b> or <code>)
#   ) $ ///

#   if lineNumber != totalLines - 1 and exp.test line
#     "#{line}<br>"
#   else
#     line

def mkdown text
  lines = text.split /\n/
#   totalLines = lines.length
#   lineNumber = -1

  output = lines.map do | line |
#     lineNumber++
#     breakLine emphasis headers lists code escape line
    emphs hders lists line
  end
  output.join ""
end