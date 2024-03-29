require 'open-uri'
require 'json'
require 'nokogiri'


url = 'https://metabattle.com/wiki/PvP_Builds'
html = URI.open(url)

doc = Nokogiri::HTML(html)
count = 0
showings = []

doc.css('.build-row').each do |element|
    element.at_css('.build-row-title a') ? element_title =  element.at_css('.build-row-title a').text.strip : nil
    element.at_css('.build-row-rating') ?  element_rating = element.at_css('.build-row-rating').text.strip : nil
    element.at_css('.me-2 img') ? element_rang = element.at_css('.me-2 img') : nil
    element_rang ? element_rang_name = element_rang['alt'] : nil
    element.at_css('.d-flex .d-flex .d-flex.me-3') ? element_difficulty = element.at_css('.d-flex .d-flex .d-flex.me-3') : nil
    element_difficulty ? element_difficulty_rang = element_difficulty['title'].slice(12..20) : nil

    element_tree_names = []

    element.css('.d-flex .d-flex > .me-3 > div').each do |tree|
        tree.at_css('img') ? tree_img = tree.at_css('img') : nil
        tree_img ? element_tree_names << tree_img['alt'] : nil
    end


    element_title ? count = count + 1 : nil

    element_title ? showings.push(
        id: count,
        rang: element_rang_name,
        title: element_title,
        tree: element_tree_names,
        difficulty: element_difficulty_rang,
        rating: element_rating
    ) : nil
end

puts JSON.pretty_generate(showings)