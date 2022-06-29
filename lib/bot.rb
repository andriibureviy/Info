# frozen_string_literal: true

require 'telegram/bot'
require_relative 'casualty'

class Bot
  def initialize
    token = '5422485728:AAH-ZTkHbmpM53i5XYxJZiygx-lJx-4F9do'

    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message.text

        when '/start'

          bot.api.send_message(chat_id: message.chat.id,
                               text: "Привіт!, #{message.from.first_name} ,Дізнатися втрати російських окупантів #{Time.new.strftime('%Y-%m-%d')} /details ")

        when '/stop'

          bot.api.send_message(chat_id: message.chat.id, text: "Папа, любий друже #{message.from.first_name}",
                               date: message.date)

        when '/details'
          value = Casualty.new.make_the_request

          bot.api.send_message(chat_id: message.chat.id,
                               text: "Втрати російських окупантів за #{Time.new.strftime('%Y-%m-%d')} \n\n#{value} ", date: message.date)

        else bot.api.send_message(chat_id: message.chat.id,
                                  text: "Напишіть будь ласка, #{message.from.first_name}, you need to use  /start,  /stop , /details")
        end
      end
    end
  end
end
