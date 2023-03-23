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
    select_side
  end

  def select_side
    puts 'Enter Y (Face the CCP) or N (Join the CCP)'
    valid_response = %w[Y N]
    chosen = gets.chomp
    until valid_response.include?(chosen.upcase)
      puts 'Enter Y or N NOW!!!'
      chosen = gets.chomp
    end
    game_path(chosen)
  end

  def game_path(chosen)
    if chosen.upcase == 'Y'
      intro_dialogue_human
      human
    elsif chosen.upcase == 'N'
      intro_dialogue_ccp
      computer
    end
  end

  def human
    for i in 0..3 do
      user_input
      @win_checker == 30 ? break : nil
    end
    if i == 3 && @win_checker != 30
      puts 'YOU SUCK!'
    end
  end

  def user_input
    choice = gets.chomp
    choice_arr = choice.upcase.split('')
    valid_options = @array
    primary_check(choice_arr, valid_options, choice)
  end

  def intro_dialogue_human
    puts 'Welcome to Mastermind!'
    puts 'The CCP has planted an explosive! Defuse it with a code consisting of 4 colors'
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

  # computer portion
  def intro_dialogue_ccp
    puts 'Welcome to Mastermind!'
    puts 'Your first assignment as a CCP Agent is to generate a security code for our bomb'
    puts 'Enter a 4 letter combination based from [R G B Y O P], choose wisely!'
  end

  def computer
    user_input_ccp
  end

  def user_input_ccp
    security_code = gets.chomp
    security_arr = security_code.upcase.split('')
    valid_security_options = @array
    security_check(security_arr, valid_security_options, security_code)
  end

  # Can further refactor
  def security_check(security_arr, valid_security_options, security_code)
    until valid_security_options.include?(security_arr[0]) && valid_security_options.include?(security_arr[1]) &&
          valid_security_options.include?(security_arr[2]) && valid_security_options.include?(security_arr[3]) &&
          security_code.length == 4
      puts 'Enter a 4 letter password based from [R G B Y O P]! -Social Credit!'
      security_arr = (security_code = gets.chomp).upcase.split('')
    end
    computer_algorithm(security_arr)
  end

  def computer_algorithm(security_arr)
    remaining_pool = @array
    computer_solution = %w[0 0 0 0]
    for u in 0..4 do
      computer_choice = remaining_pool.sample(4)
      computer_win(computer_choice, computer_solution, remaining_pool, security_arr)
      @win_checker == 50 ? break : nil
    end
    if u == 4 && @win_checker != 50
      puts 'Congratulations Comrade! You Bested the AI!'
    end
  end

  def computer_win(computer_choice, computer_solution, remaining_pool, security_arr)
    computer_sort(computer_choice, computer_solution, remaining_pool, security_arr)
    if computer_solution == security_arr
      puts 'Your Have Failed us! You are Fired!'
      @win_checker = 50
    end
  end

  def computer_sort(computer_choice, computer_solution, remaining_pool, security_arr)
    security_arr.each_with_index do |secure, z|
      if computer_choice[z] == secure
        computer_solution[z] = computer_choice[z]
        remaining_pool.delete(computer_choice[z])
      end
      remaining_pool = remaining_pool.select { |color| security_arr.include?(color) }
    end
    puts computer_solution.inspect
  end
end

Mastermind.new(colors).game
