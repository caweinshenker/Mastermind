module Mastermind
  class Codebreaker

    attr_accessor :guess, :past_guesses, :guess_number
    @@colors = {1 => "red", 2=> "blue", 3 =>"green", 4 => "orange", 5 => "purple", 6 => "yellow"}
    def initialize(player = true, guess = [])
      @past_guesses = Hash.new([])
      @guess_number = 0
      @guess = player ? input_guess(guess) : computer_guess
    end

    #Accepts either an array of colors or allows the user to select colors
    #for next guess
    def input_guess(guess = [])
      if guess == []
        puts "The valid colors are #{@@colors.values}"
        4.times do
          puts "Enter a number 1-6"
          guess.push(@@colors[gets.chomp.to_i])
        end
      end
      @guess_number += 1
      @past_guesses[@guess_number] =  [].push(guess)
      guess
    end

    def new_guess(guess = [])
      @guess = input_guess(guess)
    end

    #Place the response from the codemaker as the second element in the array
    #that is the hash value corresponding to the guess number
    def record_response(response)
      @past_guesses[guess_number] = @past_guesses[guess_number].push(response)
    end

    def computer_guess
    end

    #Display an input number of past guesses and their results
    #If no number is input, all past guesses are shown
    def display_guesses(number = @guess_number)
      for i in (@guess_number - number..@guess_number) do
        puts "Guess: #{i}, #{@past_guesses[i][0]}, #{@past_guesses[i][1]}"
      end
    end

  end
end
