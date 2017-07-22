require './lib/reply_markup_formatter'
require './lib/app_configurator'

class MessageSender
  attr_reader :bot
  attr_reader :text
  attr_reader :chat
  attr_reader :answers
  attr_reader :logger
  attr_reader :inline
	attr_reader :query_id
	attr_reader :inline_mode

  def initialize(options)
    @bot = options[:bot]
    @text = options[:text]
    @chat = options[:chat]
    @answers = options[:answers]
	  @inline = options[:inline]
		@inline_mode = options[:inline_mode]
		@query_id = options[:query_id]
    @logger = AppConfigurator.new.get_logger
  end

  def send
    if reply_markup&&inline_mode
			bot.api.answer_inline_query(inline_query_id: query_id.to_s, results: answers,cache_time:0)
		elsif reply_markup	
      bot.api.send_message(chat_id: chat.id, text: text, reply_markup: reply_markup)
    else
      bot.api.send_message(chat_id: chat.id, text: text)
    end

  #  logger.debug "sending '#{text}' to #{chat.username}"
  end


  private
	 def reply_markup
		 if answers&&inline
			 ReplyMarkupFormatter.new(answers).get_inline_markup    
		 elsif answers
			 ReplyMarkupFormatter.new(answers).get_markup
		 end
	 end
  end
