# frozen_string_literal: true

colors = %w[R G B Y O P]

# mastermind class
class Mastermind
  def initialize(array)
    @array = array
    @code = @array.sample(4)
    @win_checker = 10
  end

  def game
    intro_dialogue
    select_side
    if choice == 'Y'
      human
    elsif choice == 'N'
      computer
    end
  end

  def select_side
    puts 'Enter Y (Face the CCP) or N (Join the CCP)'
    valid_response = %w[Y N]
    choice = gets.chomp
    until valid_response.include?(choice.upcase)
      puts 'Enter Y or N NOW!!!'
      choice = gets.chomp
    end
  end

  def human 
    for i in 0..3
      user_input
      @win_checker == 30 ? break : nil
    end
    result = i == 3 ? 'You Suck!' : ''
    puts result
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
    puts 'Enter a 4 letter combination based from [R G B Y O P], you have 4 guesses'
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
      puts 'You stopped the CCP! Congratulations on Deciphering the Code!'
      @win_checker = 30
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
