class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  
  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(char)
    if char.nil? || !'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.include?(char) || char == '' 
      raise ArgumentError
    elsif @guesses.include?(char.downcase) || @wrong_guesses.include?(char.downcase)
      return false
    elsif @word.include?(char)
      @guesses << char
    else
      @wrong_guesses << char
    end
  end

  def check_win_or_lose
    num_unique_chars = @word.chars.uniq.join.length
    puts "GUESSES: #{@guesses}; LENGTH: #{@guesses.length}"
    puts "SECRET_WORD: #{@word}; LENGTH: #{@word.length}"
    if @guesses.length == num_unique_chars
      :win
    elsif @wrong_guesses.length < 7
      :play
    else
      :lose
    end
  end

  def word_with_guesses
    string = ''
    @word.each_char do |char|
      if @guesses.include?(char)
        string << char
      else
        string << '-'
      end
    end
    string
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
