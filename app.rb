require 'sinatra'

get '/' do
  erb :index
end

post '/' do
  text = params[:text]
  highlights = [
    { start: 20, end: 35, comment: "Foo" },
    { start: 73, end: 92, comment: "Bar" },
    { start: 50, end: 98, comment: "Baz" }
    ]
    paragraphs = text.split("\n\n")

   
    paragraphs.map! do |paragraph|
      
      matches = []
      highlights.each do |highlight|
        start_index = highlight[:start]
        end_index = highlight[:end]
        while start_index < paragraph.length && (index = paragraph.index(/(?<=\b|\W).{#{start_index}}(?=\b|\W)/, start_index))
          if index < end_index
            matches << { start: index, end: [end_index, paragraph.length].min, comment: highlight[:comment] }
            start_index = index + 1
          else
            break
          end
        end
      end
      
      
      highlighted_paragraph = ""
      current_index = 0
      matches.each do |match|
        highlighted_paragraph += paragraph[current_index...match[:start]]
        highlighted_paragraph += "<span class='highlight' data='#{match[:comment]}'>#{paragraph[match[:start]...match[:end]]}</span>"
        current_index = match[:end]
      end
      highlighted_paragraph += paragraph[current_index...paragraph.length]
  
      "<p>#{highlighted_paragraph}</p>"
    end
  
    @highlighted_text = paragraphs.join('')
    erb :index
  end
