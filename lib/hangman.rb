class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word 
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars 
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index {|ch, idx| indices << idx if ch == char}
    indices
  end

  def fill_indices(char, indices)
    indices.each do |idx|
      @guess_word[idx] = char
    end
  end

  def try_guess(char)
    if !already_attempted?(char)
      @attempted_chars << char
      matches = get_matching_indices(char)
      if !matches.empty?
        fill_indices(char, matches)
      else 
        @remaining_incorrect_guesses -= 1
      end
      true
    else 
      p 'that has already been attempted'
      false
    end
  end

  def ask_user_for_guess
    p 'Enter a char:'
    user_res = gets.chomp
    try_guess(user_res)
  end

  def win?
    if @guess_word.join("") == @secret_word
      p "WIN"
      true 
    else 
      false 
    end
  end

  def lose? 
    if @remaining_incorrect_guesses == 0 
      p "LOSE"
      true 
    else 
      false 
    end
  end

  def game_over?
    if win? || lose?
      p @secret_word
      true 
    else 
      false 
    end
  end

end
