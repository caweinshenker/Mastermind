module Mastermind
  class Codemaker
    attr_accessor :code, :code_hash
    @@colors = {1 => "red", 2=> "blue", 3 =>"green", 4 => "orange", 5 => "purple", 6 => "yellow"}

    def initialize(player = false)
      @code = player ? input_code : random_code
      if player
        puts "You are the mastermind!"
      end
    end

    def random_code
      @code = []
      4.times do
        @code.push(@@colors[rand(1..6)])
      end
      set_code_hash
      @code
    end

    def set_code_hash
      @code_hash = Hash.new(0)
      @code.each do |key|
        if @code_hash.has_key?(key)
          @code_hash[key] = @code_hash[key] + 1
        else
          @code_hash[key] = 1
        end
      end
    end

    def input_code
      puts "The valid colors are #{@@colors}"
      @code = []
      4.times do
        puts "Enter a number 1-6"
        @code.push(@@colors[gets.chomp.to_i])
      end
      set_code_hash
      @code
    end

    #Just for testing purposes
    def set_code(code)
      @code = []
      code.each do |color|
        @code.push(@@colors[color])
      end
      set_code_hash
      @code
    end

    def respond(guess)
      temp_code_hash = @code_hash.clone
      checked_indices = []
      black_pegs = 0
      white_pegs = 0
      for i in (0..3) do
        color = guess[i]
        if color == @code[i]
          black_pegs += 1
          temp_code_hash[color] = temp_code_hash[color] - 1
          checked_indices.push(i)
        end
      end
      for i in (0..3) do
        color = guess[i]
        if @code.include?(color) && temp_code_hash[color] > 0 && !checked_indices.include?(i)
          white_pegs += 1
          temp_code_hash[color] = temp_code_hash[color] -1
        end
      end
      return [black_pegs, white_pegs]
    end

    def give_answer
      @code
    end

  end
end
