require "spec_helper"

module Mastermind
  describe Game do

    describe "#initialize" do
      it "creates codebreaker and instance classes and starts play" do
        game = Game.new()
        game.player = true
        expect(game.codemaker).to be_truthy
        expect(game.codebreaker).to be_truthy
        #expect(game.player).to be_truthy
      end
    end



    # describe "play" do
    #   it "handles the gameplay and initiates an endgame" do
    #     game = Game.new();
    #     game.player = true;
    #     game.play();
    #   end
    # end

  end
end
