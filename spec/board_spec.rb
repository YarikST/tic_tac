require "spec_helper"

describe 'Board' do
  context "#initialize" do
    it "is initialized with default value" do
      board = Board.new
      expect(board.players.length).to be 0
      expect(board.calls.length).to be 9
      expect(board.winning_combination).to eq [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 8]]
    end
  end
  context "#make_move" do
    it "is raise exception with invalid move_type" do
      board = Board.new

      board.make_move(0, MoveTypes::CRISS_CROSS)

      expect {board.make_move(1, MoveTypes::CRISS_CROSS)}.to raise_error(MoveTypeException)
    end
    it "is raise exception re-entry" do
      board = Board.new

      board.make_move(0, MoveTypes::CRISS_CROSS)

      expect {board.make_move(0, MoveTypes::ZERO)}.to raise_error(CallPresentException)
    end
    it "is set move_type to call" do
      board = Board.new

      board.make_move(0, MoveTypes::CRISS_CROSS)

      expect(board.calls[0].move_type).to eq MoveTypes::CRISS_CROSS
    end
    it "is set move_type to last_move_type" do
      board = Board.new

      board.make_move(0, MoveTypes::CRISS_CROSS)

      expect(board.last_move_type).to eq MoveTypes::CRISS_CROSS
    end
  end
  context "#games_completed" do
    it "winning upright" do
      board = Board.new

      board.make_move(0, MoveTypes::ZERO)
      board.make_move(1, MoveTypes::CRISS_CROSS)

      board.make_move(2, MoveTypes::ZERO)
      board.make_move(4, MoveTypes::CRISS_CROSS)

      board.make_move(5, MoveTypes::ZERO)
      board.make_move(7, MoveTypes::CRISS_CROSS)

      expect(board.combination_completed).to eq [1, 4, 7]
    end
    it "won horizontally" do
      board = Board.new

      board.make_move(0, MoveTypes::ZERO)
      board.make_move(3, MoveTypes::CRISS_CROSS)

      board.make_move(2, MoveTypes::ZERO)
      board.make_move(4, MoveTypes::CRISS_CROSS)

      board.make_move(7, MoveTypes::ZERO)
      board.make_move(5, MoveTypes::CRISS_CROSS)

      expect(board.combination_completed).to eq [3, 4, 5]
    end
    it "won diagonally" do
      board = Board.new

      board.make_move(0, MoveTypes::ZERO)
      board.make_move(2, MoveTypes::CRISS_CROSS)

      board.make_move(1, MoveTypes::ZERO)
      board.make_move(5, MoveTypes::CRISS_CROSS)

      board.make_move(7, MoveTypes::ZERO)
      board.make_move(8, MoveTypes::CRISS_CROSS)

      expect(board.combination_completed).to eq [2, 5, 8]
    end
    it "nightly" do
      board = Board.new

      board.make_move(0, MoveTypes::ZERO)
      board.make_move(1, MoveTypes::CRISS_CROSS)

      board.make_move(2, MoveTypes::ZERO)
      board.make_move(3, MoveTypes::CRISS_CROSS)

      board.make_move(4, MoveTypes::ZERO)
      board.make_move(8, MoveTypes::CRISS_CROSS)

      board.make_move(7, MoveTypes::ZERO)
      board.make_move(6, MoveTypes::CRISS_CROSS)

      board.make_move(5, MoveTypes::ZERO)

      expect(board.combination_completed).to eq nil
      expect(board.games_completed).to eq WinnerTypes::MULTI
    end
  end
end