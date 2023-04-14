require 'sinatra'

get '/' do
  erb :index
end

post '/highlight' do
  text = params[:text]
  highlights = [
    { start: 20, end: 35, comment: "Foo" },
    { start: 73, end: 92, comment: "Bar" },
    { start: 50, end: 98, comment: "Baz" }
    ]
  @text="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas consectetur malesuada
  velit, sit amet porta magna maximus nec. Aliquam aliquet tincidunt enim vel rutrum. Ut
  augue lorem, rutrum et turpis in, molestie mollis nisi. Ut dapibus erat eget felis pulvinar, ac
  vestibulum augue bibendum. Quisque sagittis magna nisi. Sed aliquam porttitor
  fermentum. Nulla consequat justo eu nulla sollicitudin auctor. Sed porta enim non diam
  mollis, a ullamcorper dolor molestie. Nam eu ex non nisl viverra hendrerit. Donec ante
  augue, eleifend vel eleifend quis, laoreet volutpat ipsum. Integer viverra aliquam nulla, ac
  rutrum dui sodales nec."
  paragraphs = text.split("\n").map { |paragraph| "<p>#{paragraph}</p>" }
  
  highlights.each do |highlight|
    start_index = highlight[:start]
    end_index = highlight[:end]
    comment = highlight[:comment]
    
    # Ajout des balises HTML pour surligner et afficher l'infobulle
    paragraphs.each do |paragraph|
      if start_index < paragraph.length && end_index >= start_index
        highlighted_text = paragraph[start_index..[end_index, paragraph.length - 1].min]
        highlighted_text = "<span class=\"highlight\" data-tooltip=\"#{comment}\">#{highlighted_text}</span>"
        paragraph[start_index..end_index] = highlighted_text
        start_index = end_index + highlighted_text.length - (end_index - start_index + 1)
      end
    end
  end
  
  @highlighted_text = paragraphs.join('')
  erb :result
end
