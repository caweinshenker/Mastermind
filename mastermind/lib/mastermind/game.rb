module Mastermind
  class Game

    attr_accessor :player, :codemaker, :codebreaker

    def initialize
      puts "Welcome to Mastermind!"
      puts "Would you like to guess? (y/n)"
      @player = gets.chomp == "y" ? true : false
      @codemaker = Mastermind::Codemaker.new(!@player)
      @codebreaker = Mastermind::Codebreaker.new(@player)
      @win = false
    end

    def play
      guesses = 12
      puts "#{guesses} guesses remaining"
      guess = @codebreaker.guess()
      guesses -= 1
      while (guesses > 0) do
        if @player
          give_feedback(guess)
        else
          give_computer_feedback(guess)
        end
        if @win
          break
        else
          puts "Guesses remaining: #{guesses}"
          guess = next_move()
        end
        guesses -= 1
      end
      game_over()
    end

    def give_computer_feedback(guess)
      response = @codemaker.respond(guess)
      @codebreaker.record_response(response)
      puts "The computer guessed: #{guess}"
      puts "Results: #{response[0]} black pegs, #{response[1]} white pegs"
      if response == [4,0]
        @win = true
      end
    end

    def give_feedback(guess)
      response = @codemaker.respond(guess)
      @codebreaker.record_response(response)
      puts "You guessed: #{guess}"
      puts "Results: #{response[0]} black pegs, #{response[1]} white pegs"
      if response == [4,0]
        @win = true
      end
    end

    def next_move
      if @player
        puts "Enter 'p' to see past guesses and results"
        puts "Or 'g' to guess again"
        puts "Or 's' to give up"
        nextMove = gets.chomp
        moveMade = false;
        while moveMade == false do
          if nextMove == 'p'
              @codebreaker.display_guesses()
          elsif nextMove == 'g'
              guess = @codebreaker.input_guess()
              moveMade = true
              break
          elsif nextMove == 's'
            game_over
          else
            puts "Invalid input. Try again."
          end
          nextMove = gets.chomp
        end
      else
        guess = @codebreaker.guess
      end
      guess
    end

    def game_over
      if @player
        if @win
          puts "You win!"
        else
          puts "You lose!"
          print "The answer was #{@codemaker.code}"
        end
      else
        if @win
          puts "You lose!"
        else
          puts "You win!"
          puts "The computer couldn't guess the code!"
        end
      end
      abort()
    end

  end
end
