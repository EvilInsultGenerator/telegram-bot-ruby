require './models/user'
require './lib/message_sender'
require 'httpclient'

class MessageResponder
  attr_reader :message
  attr_reader :bot
  attr_reader :user
  attr_reader :mode

  def initialize(options)
    @bot = options[:bot]
    @message = options[:message]
    @user = User.find_or_create_by(uid: message.from.id)
  end

  def respond
		case message
			when Telegram::Bot::Types::InlineQuery
				# Here you can handle your inline commands
					execute_commands   
			when Telegram::Bot::Types::CallbackQuery
				# Here you can handle your callbacks from inline buttons
				  bot.track('switch_lang', message.from.id, choosen_lang: message.data)
					change_lang
			when Telegram::Bot::Types::Message   		
					execute_commands   
			end		
  end

  private

	def execute_commands
		if message.respond_to?(:text) 
			content,@mode=[message.text,'inchat']
		elsif message.respond_to?(:query)  
			content,@mode=[message.query,'inline']
		end	
		case content
			when '/start'
				answer_with_greeting_message if mode=='inchat'
			when '/stop'
				answer_with_farewell_message if mode=='inchat'
			when /Generate insult/i
				bot.track('gen_insult', message.from.id, mode:@mode)
				generate_insult	
			when /(language|lang)/i
				bot.track('Request_to_switch_lang', message.from.id, mode:@mode)
				show_language	
			when /homepage/i
				show_homepage	if mode=='inchat'
			else
				if @mode=='inline'
					bot.track('gen_insult', message.from.id, mode:@mode)
					generate_insult
				else
					MessageSender.new(bot: bot, 
														chat: message.from, 
														text: "Sorry, I do not understand \u2639").send
				end	
		end
	end	

  def answer_with_greeting_message
    text = I18n.t('greeting_message')
		answers=[
			'Generate Insult',
			['Language','Homepage']
		]
    MessageSender.new(bot: bot, 
											chat: message.from,
										 	answers:answers, 
											text: "#{text} \u{1F479}").send

  end

  def answer_with_farewell_message
    text = I18n.t('farewell_message')

    MessageSender.new(bot: bot, chat: message.from, text: text).send
  end

	def lang
		@user.lang ||='en'
	end

	def change_lang
		@user.lang=message.data
		@user.save
		text = "Language changed to #{lang}" #I18n.t('farewell_message')
    MessageSender.new(bot: bot, chat: message.from, text: text).send
	end	 

	def generate_insult
		clnt = HTTPClient.new
		uri = URI.parse("http://evilinsult.com/generate_insult.php?lang=#{lang}")
		response = clnt.get_content(uri)
		text=response
		if @mode=='inchat'
			MessageSender.new(bot: bot, chat: message.from, text: text).send
		else
			answers=
					 [
						 Telegram::Bot::Types::InlineQueryResultArticle.new(
							 id: rand(100),
							 title: 'Insult',
							 input_message_content:
							 Telegram::Bot::Types::InputTextMessageContent.new(
								 message_text:text, 
								 disable_web_page_preview: true
							 ),
							 thumb_url:'http://a5.mzstatic.com/us/r30/Purple3/v4/94/77/85/947785f3-5056-a1c5-dbf2-d6688b215403/icon175x175.png',
							 description: text
						 )
					]
	MessageSender.new(bot: bot, 
										query_id: message.id, 
										answers:answers, 
										inline_mode:true).send   
		end		
	rescue
		
end	

def show_language
	text="Your current language is: #{lang}\nChoose the language:"
	languages=['en','zh','es','hi','ar','pt','bn','ru','ja','jv','sw','de','ko','fr','te','mr','tr','ta','vi','ur','el','it','cs','la']
	languages.map!{|answer| 
					Telegram::Bot::Types::InlineKeyboardButton.new(
					text:answer, 
					callback_data: answer
				)
			}
	if @mode=='inchat'
		MessageSender.new(bot: bot,
										 	chat: message.from,
										 	answers:languages, inline:true,
										 	text: text).send
	else
		answers=
			 [
				 Telegram::Bot::Types::InlineQueryResultArticle.new(
					 id: rand(100),
					 title: 'Insult',
					 input_message_content:
						 Telegram::Bot::Types::InputTextMessageContent.new(
							 message_text:text, 
							 disable_web_page_preview: true
						 ),
					 reply_markup: 
						 Telegram::Bot::Types::InlineKeyboardMarkup.new(
							 inline_keyboard: languages.each_slice(4).to_a
						 ),
						 thumb_url:'https://cdn4.iconfinder.com/data/icons/logos-4/24/Translate-128.png',
					 description: text
				 )
				]
		MessageSender.new(bot: bot, 
											query_id: message.id, 
											answers:answers, 
											inline_mode:true).send   
	end	
end	

def show_homepage
	text="http://evilinsult.com/"
	MessageSender.new(bot: bot, chat: message.from,text: text).send
end
end
