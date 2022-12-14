# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/players'

RSpec.describe Game do
    
  describe '#player_switch' do
    subject(:game) { Game.new }
    context 'when an id is given' do
      
      it 'returns 1' do
        expect(game.player_switch(0)).to eq(1)
      end
    end
  end

  describe '#player_symbol' do
    context 'when an id is given' do
  
      let(:game) { instance_double(Game) }
      
      before do
        allow(game).to receive(:player_symbol).and_return("✦")
      end
  
      it 'returns ✦' do
        expect( game.player_symbol(0)).to eq("✦")
      end
  
    end
  end

  describe '#game_over' do
    subject(:game) { Game.new }
    let(:board) { Board.new }
    context 'when it is not game over' do
      
      it 'returns false' do
        expect(game.game_over("☀")).to eq(false)
      end
    end

    context 'when it is a vertical win' do

      before do
        board.board= [
          ["☀", 2, 3, 4],
          ["☀", 2, 3, 4],
          ["☀", 2, 3, 4],
          ["☀", 2, 3, 4]
      ]
      game.board=board
      end

      it 'returns true' do
        expect(game.game_over("☀")).to eq(true)
      end
    end

    context 'when it is a horizontal win' do

      before do
        board.board= [
          ["☀", "☀", "☀", "☀"],
          [1, 2, 3, 4],
          [1, 2, 3, 4],
          [1, 2, 3, 4]
      ]
      game.board=board
      end

      it 'returns true' do
        expect(game.game_over("☀")).to eq(true)
      end

    end

    context 'when it is a diagonal win' do

      before do
        board.board= [
          ["☀", 2, 3, 4],
          [1, "☀", 3, 4],
          [1, 2, "☀", 4],
          [1, 2, 3, "☀"]
      ]
      game.board=board
      end

      it 'returns true for the left diagonal' do
        expect(game.game_over("☀")).to eq(true)
      end

      before do
        board.board= [
          [1, 2, 3, "☀"],
          [1, 2, "☀", 4],
          [1, "☀", 3, 4],
          ["☀", 2, 3, 4]
      ]
      game.board=board
      end

      it 'returns true for the right diagonal' do
        expect(game.game_over("☀")).to eq(true)
      end

    end


  end

  describe '#tie' do
    subject(:game) { Game.new }
    let(:board) { Board.new }
    context 'when there is no winner and no possible moves' do

      before do
        board.board= [
          ['☢', '☢', '☢', "☀"],
          ['☢', '☢', "☀", '☢'],
          ["☀", '☢', "☀", '☢'],
          ["☀", "☀", '☢', '☢']
      ]
      game.board=board
      end
      
      it 'returns true' do
        expect(game.tie).to eq(true)
      end
    end
  end
  
end
