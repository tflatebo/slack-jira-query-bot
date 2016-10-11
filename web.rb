require 'nokogiri'
require 'open-uri'
require 'sinatra'
require 'haml'
require 'date'
require 'digest/md5'

class SlackJIRABot
  attr_accessor :title, :url, :text_content, :html_content, :image_uri

  def initialize
    @title = "Anita's Daily Lunch Special"
    @url = 'http://www.truetastes.com/anitas-cafe-lunch-catering/'
    @content = "I can't find their lunch special, maybe it's Whipped potatoes? Visit <a href='http://www.truetastes.com/anitas-cafe-lunch-catering/'>their site</a> if you see this message."
    @image_uri = 'http://www.truetastes.com/wp-content/themes/anita/ui/img/special_1.jpg'
  end

end

get '/', :provides => 'html' do
  @lunch_special = get_anitas
  haml :index
end

get '/jira-search' do

  
  
  #return jira_search
end

# new parsing that pulls in their HTML formatting, but we lose the date parsing
def jira_search

  @lunch_special = SlackJIRABot.new
  doc = Nokogiri::HTML(open('http://www.truetastes.com/anitas-cafe-lunch-catering/'))

  ####
  # Search for nodes by css

  if(doc)
    doc.css('div.specials_copy').each do |specials|
      @lunch_special.html_content = specials.inner_html
      @lunch_special.text_content = specials.content
    end
  end

  return @lunch_special

end
