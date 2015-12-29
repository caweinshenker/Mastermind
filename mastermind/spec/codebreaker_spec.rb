require "spec_helper"
module Mastermind
  describe Codebreaker do

    describe "#initialize" do
      it "Creates a current guess and adds it to the hash of past guesses" do
        breaker = Codebreaker.new(true, ["red", "blue", "green", "yellow"])
        expect(breaker.guess).to eq ["red", "blue", "green", "yellow"]
        expect(breaker.guess_number).to eq 1
        expect(breaker.past_guesses).to eq({1 => [["red", "blue", "green", "yellow"]]})
      end
    end

  end
end
