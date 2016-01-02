require "spec_helper"
module Mastermind
  describe Codebreaker do

    describe "#initialize" do
      it "Creates a current guess and adds it to the hash of past guesses" do
        breaker = Codebreaker.new(true)
        expect(breaker.guess_number).to eq 0
        breaker.guess(["red", "blue", "green", "yellow"])
        expect(breaker.guess_number).to eq 1
        expect(breaker.past_guesses).to eq({1 => [["red", "blue", "green", "yellow"]]})
      end
    end

    describe "random_guess" do
      it "Creates a random guess of four different strings" do
        breaker = Codebreaker.new(true)
        expect(breaker.random_guess).to not eq(breaker.random_guess)
      end
    end

    describe "find_best_past_guess" do
      it "Returns the best past guess according to the heuristics given" do
        breaker = Codebreaker.new(true)
        mastermind = Codemaker.new(true)
        mastermind.set_code(["red", "blue", "green", "yellow"])
        breaker.guess(["red", "blue", "purple", "yellow"])
        breaker.guess(["red", "blue", "blue", "yellow"])
        breaker.guess("purple", "blue", "blue", "purple"])
        expect(breaker.find_best_past_guess).to eq([["red", "blue", "blue", "yellow"], [3, 0]])
      end
    end

    

  end
end
