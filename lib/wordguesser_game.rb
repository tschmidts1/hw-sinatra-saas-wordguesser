class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses, :working_word

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @working_word = word.split('').each{|a| a.replace('-')}
  end

  def guess(letter)
    # puts word, letter, word.include?(letter)

    raise ArgumentError.new("Expected single alphabetical letter. Got nil.") if letter == nil
    raise ArgumentError.new("Expected single alphabetical letter. Got #{letter}.") unless letter.match(/\A[a-zA-Z]\z/)
    letter = letter.downcase
    if !self.guesses.include?(letter) and !self.wrong_guesses.include?(letter)
      if word.include?(letter)
        self.guesses << letter
        word.split('').each_index {|a| if word[a].match(letter)
                              self.working_word[a]=word[a] end}
      else
        self.wrong_guesses << letter
      end
    else
      false
    end
  end

  def word_with_guesses
    self.working_word.join
  end

  def check_win_or_lose
    if !working_word.include?('-')
      :win
    elsif wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesser.get_random_word
  #  => "cooking"   <-- some random word
  # This works!!
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
