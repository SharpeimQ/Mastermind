# frozen_string_literal: true

colors = %w[R G B Y O P]

# mastermind class
class Mastermind
  def initialize(array)
    @array = array
    @code = @array.sample(4)
  end

  def game
    intro_dialogue
    user_input
  end

  def user_input
    choice = gets.chomp
    choice_arr = choice.upcase.split('')
    valid_options = @array
    until valid_options.include?(choice_arr[0]) && valid_options.include?(choice_arr[1]) &&
          valid_options.include?(choice_arr[2]) && valid_options.include?(choice_arr[3]) && choice.length == 4
      puts 'Enter a 4 letter combination based from [R G B Y O P]'
      choice_arr = (choice = gets.chomp).upcase.split('')
    end
  end

  def intro_dialogue
    puts 'Welcome to Mastermind'
    puts 'the computer has generated a code consisting of 4 colors'
    puts 'Enter a 4 letter combination based from [R G B Y O P]'
    puts @code.inspect
  end

end

player = Mastermind.new(colors)
player.game
