module Mastermind
  class Code
    @@colors = {1 : "red", 2 : "blue", 3: "green", 4: "orange", 5: "purple", 6 : "yellow"}
    def initialize(player = false)
      @code = player ? random_code : input_code
    end

    def random_code
      @code = []
      4.times do
        @code << @@colors[rand(1..6)]
      end
    end

    def input_code
      4.times do
        puts "Enter a number 1-6"
        @code << @@colors[gets.chomp.to_i]
      end
    end

    def get_code
      @code
    end
    
  end
end
