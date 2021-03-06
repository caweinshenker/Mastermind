require "spec_helper"
module Mastermind
  describe Codemaker do

    describe "initialize" do
      it "Chooses the secret code either randomly or by user input" do
        secret = Codemaker.new(false)
        secret.set_code([1, 3, 2, 6])
        expect(secret.code).to eq ["red", "green", "blue", "yellow"]
      end
    end

    describe "respond" do
      it "Returns an array of the number of black pegs and white pegs" do
        secret = Codemaker.new(false)
        secret.set_code([1, 3, 2, 6])
        guess = ["red", "yellow", "purple", "red"]
        guess2 = ["blue","blue", "blue", "blue"]
        expect(secret.respond(guess)).to eq [1, 1]
        expect(secret.respond(guess2)).to eq [1,0]
      end
    end

  end
end
