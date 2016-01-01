module Mastermind
  class Game

    attr_accessor :player, :codemaker, :codebreaker

    def initialize
      puts "Would you like to guess? (y/n)"
      @player = gets.chomp == "y" ? true : false
      @codemaker = Mastermind::Codemaker.new(!@player)
      @codebreaker = Mastermind::Codebreaker.new(@player)
      @win = false
    end

    def play
      guesses = 12
      puts "#{guesses} guesses remaining"
      guess = @player ? @codebreaker.input_guess() : @codebreaker.guess()
      guesses -= 1
      while (guesses > 0) do
        response = @codemaker.respond(guess)
        @codebreaker.record_response(response)
        puts "You guessed: #{guess}"
        puts "Results: #{response[0]} black pegs, #{response[1]} white pegs"
        if response == [4, 0]
          game_over(true)
          @win = true
          break
        else
          puts "Guesses remaining: #{guesses}"
          guess = @codebreaker.guess()
        end
        guesses -= 1
      end
      if @win == false
        game_over(false)
      end
    end

    def game_over(win)
      if win == true
        puts "You win!"
      else
        puts "You lose!"
        puts "The answer was #{@codemaker.code}"
      end
    end

  end
end
