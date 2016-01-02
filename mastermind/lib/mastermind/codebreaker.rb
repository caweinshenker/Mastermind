module Mastermind
  class Codebreaker

    attr_accessor :guess, :past_guesses, :guess_number, :possibles
    @@colors = {1 => "red", 2=> "blue", 3 =>"green", 4 => "orange", 5 => "purple", 6 => "yellow"}
    def initialize(player = true)
      @player = player
      @past_guesses = Hash.new([])
      @guess_number = 0
    end

    #General purpose guess method
    #Calls helper methods
    def guess(guess = [])
      @guess = @player ? input_guess(guess) : computer_guess
      @past_guesses[@guess_number] = [].push(@guess)
      @guess
    end

    #Accepts either an array of colors or allows the user to select colors
    #for next guess
    def input_guess(guess = [])
      if guess == []
        @guess = []
        puts "The valid colors are #{@@colors}"
        4.times do
          puts "Enter a number 1-6"
          @guess.push(@@colors[gets.chomp.to_i])
        end
      else
        @guess = guess
      end
      @guess
    end

    #Place the response from the codemaker as the second element in the array
    #that is the hash value corresponding to the guess number
    def record_response(response)
      @past_guesses[@guess_number] = @past_guesses[@guess_number].push(response)
      @guess_number += 1
    end

    #Returns next guess
    #Guess is random if no previous guesses made
    def computer_guess
      if @guess_number == 0
        generate_possibles()
      else
        last_guess = @past_guesses[@guess_number - 1]
        remove_ineligible(last_guess[0], last_guess[1])
      end
      @guess = five_guess
      @guess
    end

    #Remove from the list of possibles all codes whose response would not
    #be equal to the mastermind's response assuming assuming the last guess was the code
    def remove_ineligible(last_guess, response)
      code_hash = get_code_hash(last_guess)
      @possibles.each do |guess|
        if calculate_response(guess, last_guess, code_hash.clone) != response
          @possibles.delete(guess)
        end
      end
      @possibles.delete(last_guess)
    end

    #Return a hash of colors to the number of times they appear in a given code
    #Input: code
    def get_code_hash(code)
      code_hash = Hash.new(0)
      code.each do |key|
        if code_hash.has_key?(key)
          code_hash[key] = code_hash[key] + 1
        else
          code_hash[key] = 1
        end
      end
      code_hash
    end

    #Calculate the response for a given guess and code
    def calculate_response(guess, code, code_hash)
      checked_indices = []
      black_pegs = 0
      white_pegs = 0
      for i in (0..3) do
        color = guess[i]
        if color == code[i]
          black_pegs += 1
          code_hash[color] = code_hash[color] - 1
          checked_indices.push(i)
        end
      end
      for i in (0..3) do
        color = guess[i]
        if code.include?(color) && code_hash[color] > 0 && !checked_indices.include?(i)
          white_pegs += 1
          code_hash[color] = code_hash[color] -1
        end
      end
      return [black_pegs, white_pegs]
    end

    #Generates all possible codes using recursive helper
    def generate_possibles
      @possibles = []
      possibles_helper()
    end

    #Generate all possible codes using recursive algorithm
    def possibles_helper(code = [])
      if code.length == 4
        if !@possibles.include?(code)
            @possibles.push(code)
        end
      else
        for i in (1..6) do
          code_tmp = code.clone.push(@@colors[i])
          possibles_helper(code_tmp)
        end
      end
    end


    #Retrieves previous best guess and makes next best guess
    #Based on five-guess algorithm by Donald Knuth (w/o minimax)
    #See https://en.wikipedia.org/wiki/Mastermind_(board_game)#Five-guess_algorithm
    def five_guess
      return @possibles[rand(0...@possibles.length)]
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
