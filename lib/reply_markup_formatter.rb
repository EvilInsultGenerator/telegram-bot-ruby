class ReplyMarkupFormatter
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def get_markup
    Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: array,resize_keyboard:true)
		#.each_slice(1).to_a, one_time_keyboard: true)
  end

	def get_inline_markup
				Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: array.each_slice(4).to_a)
	end
end
