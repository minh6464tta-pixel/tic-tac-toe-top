require_relative 'players'

# Game board
class Board
  def initialize
    @board_state = [
      ['c', '_', '_', '_'],
      ['b', '_', '_', '_'],
      ['a', '_', '_', '_'],
      [' ', '1', '2', '3']
    ]
  end

  def print_board
    @board_state.each do |row|
      row.each_with_index do |cell, index|
        print cell
        puts '' if index == 3
      end
    end
  end

  def update_board(move, mark)
    mapped_move = Player.map_move(move)
    @board_state[mapped_move[0].to_i][mapped_move[1].to_i] = mark
  end
end
