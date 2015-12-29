module Mastermind
  class Codemaker
    attr_accessor :code
    @@colors = {1 => "red", 2=> "blue", 3 =>"green", 4 => "orange", 5 => "purple", 6 => "yellow"}

    def initialize(player = false)
      @code = player ? input_code : random_code
    end

    def random_code
      code = []
      4.times do
        code.push(@@colors[rand(1..6)])
      end
      code
    end

    def input_code
      code = []
      4.times do
        puts "Enter a number 1-6"
        code.push(@@colors[gets.chomp.to_i])
      end
    end

    #Just for testing purposes
    def set_code(code)
      new_code = []
      code.each do |color|
        new_code.push(@@colors[color])
      end
      @code = new_code
    end

    def respond(guess)
      code_hash = Hash.new(0)
      @code.each do |key|
        if code_hash.has_key?(key)
          code_hash[key] = code_hash[key] + 1
        else
          code_hash[key] = 1
        end
      end
      black_pegs = 0
      white_pegs = 0
      for i in (0..3) do
        color = @code[i]
        if color == guess[i]
          black_pegs += 1
          code_hash[color] = code_hash[color] - 1
        elsif guess.include?(color) && code_hash[color] > 0
          white_pegs +=1
          code_hash[color] = code_hash[color] -1
        end
      end
      return [black_pegs, white_pegs]
    end

  end
end
