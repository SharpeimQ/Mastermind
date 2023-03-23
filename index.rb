# frozen_string_literal: true

colors = %w[R G B Y O P]

# mastermind class
class Mastermind
  def initialize(array)
    @array = array
    @code = @array.sample(4)
    @win = 10
  end

  def game
    intro_dialogue
    for i in 0..3
      user_input
      @win == 30 ? break : nil
    end
    if i == 3
      puts 'You Suck!'
    end
  end

  def user_input
    choice = gets.chomp
    choice_arr = choice.upcase.split('')
    valid_options = @array
    primary_check(choice_arr, valid_options, choice)
  end

  def intro_dialogue
    puts 'Welcome to Mastermind!'
    puts 'The CCP has generated a code consisting of 4 colors'
    puts 'Enter a 4 letter combination based from [R G B Y O P]'
    puts @code.inspect
  end

  # too lazy to change the parameters for reusability
  def primary_check(choice_arr, valid_options, choice)
    until valid_options.include?(choice_arr[0]) && valid_options.include?(choice_arr[1]) &&
          valid_options.include?(choice_arr[2]) && valid_options.include?(choice_arr[3]) && choice.length == 4
      puts 'Enter a 4 letter combination based from [R G B Y O P]!'
      choice_arr = (choice = gets.chomp).upcase.split('')
    end
    second_check(choice_arr)
  end

  def second_check(choice_arr)
    if choice_arr == @code
      puts 'You win! Congratulations on Deciphering the Code!'
      @win = 30
      return
    end
    third_check(choice_arr)
  end

  def third_check(choice_arr)
    @code.each_with_index do |color, i|
      if choice_arr[i] == color
        puts "Your #{i + 1}st Color and Spot was Correct!"
      elsif @code.include?(choice_arr[i])
        puts "Color #{i + 1} is correct, but in the wrong spot!"
      else
        puts "Color #{i + 1} is not in the code"
      end
    end
    puts "Your Guessed #{choice_arr}. Try Again! [R G B Y O P]"
  end
end

Mastermind.new(colors).game
