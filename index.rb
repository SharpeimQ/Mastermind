# frozen_string_literal: true

colors = %w[R G B Y O P]

# mastermind class
class Mastermind
  def initialize(array)
    @array = array
  end

  def game
    puts 'Welcome to Mastermind'
    puts 'the computer has generated a code consisting of 4 colors'
    puts 'You have 6 choices, choose an element in [R G B Y O P]'
    code = @array.sample(4)
    user_input
  end

  def user_input
    choice = gets.chomp
    valid_options = @array
    unless valid_options.include?(choice.upcase)
      puts 'choose a viable option inside the array [R G B Y O P]'
      choice = gets.chomp
      puts choice
    end
  end
end

player = Mastermind.new(colors)
player.game
