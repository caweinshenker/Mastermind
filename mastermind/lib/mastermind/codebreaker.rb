module Mastermind
  class Codebreaker

    attr_accessor :guess, :past_guesses, :guess_number
    @@colors = {1 => "red", 2=> "blue", 3 =>"green", 4 => "orange", 5 => "purple", 6 => "yellow"}
    def initialize(player = true, guess = [])
      @player = player
      @past_guesses = Hash.new([])
      @guess_number = 0
    end


    def guess()
      return @player ? new_guess : computer_guess
    end

    #Accepts either an array of colors or allows the user to select colors
    #for next guess
    def input_guess()
      @guess = []
      puts "The valid colors are #{@@colors}"
      4.times do
        puts "Enter a number 1-6"
        @guess.push(@@colors[gets.chomp.to_i])
      end
      @guess_number += 1
      @past_guesses[@guess_number] =  [].push(@guess)
      @guess
    end

    def new_guess()
      puts "Enter 'p' to see past guesses and results"
      puts "Or enter 'g' to guess again"
      nextMove = gets.chomp
      moveMade = false;
      while moveMade == false do
        if nextMove == 'p'
            display_guesses()
        elsif nextMove == 'g'
            @guess = input_guess()
            moveMade = true
            break
        else
          puts "Invalid input. Try again."
        end
        nextMove = gets.chomp
      end
      @guess
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
    def display_guesses()
      @past_guesses.each do |guess_number, guess|
        puts "Guess #{guess_number}: #{guess}"
      end
    end

  end
end
