# frozen_string_literal: true

require 'telegram/bot'
require 'httparty'
require 'nokogiri'
require 'pry'
require_relative 'bot'

LINK = 'https://index.minfin.com.ua/ua/russian-invading/casualties/'

class Casualty
  def parsed_page
    Nokogiri::HTML(HTTParty.get(LINK).body)
  end

  def make_the_request
    inf_last_casualty = []
    all_casualties = parsed_page.css('div.casualties')

    the_newest_casualty = all_casualties.css('ul')[0].css('li')
    the_newest_casualty.each do |item|
      inf_last_casualty << item.text
    end
    inf_last_casualty.join("\n")
  end
end
