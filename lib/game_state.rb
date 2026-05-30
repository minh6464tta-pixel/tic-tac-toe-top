require_relative 'board'
require_relative 'players'

# Game state consisting of a board, two players
class GameState
  LEGAL_MOVES = %w[a1 a2 a3 b1 b2 b3 c1 c2 c3].freeze

  def initialize
    @moves = []
    @board = Board.new
    @player1 = Player.new('X')
    @player2 = Player.new('O')
    @is_player1_turn = true
    @is_over = false
  end

  def valid_input?(move)
    !@moves.include?(move) && LEGAL_MOVES.include?(move)
  end

  def move(player)
    move_made_this_turn = nil
    loop do
      move_made_this_turn = player.make_move
      break if valid_input?(move_made_this_turn)
    end
    @moves.push(move_made_this_turn)
    @board.update_board(move_made_this_turn, player.mark)
  end

  def play # rubocop:disable Metrics/MethodLength
    until @is_over
      @board.print_board
      if @is_player1_turn
        move(@player1)
      else
        move(@player2)
      end
      @is_player1_turn = !@is_player1_turn
      @is_over = true if @moves.length == 9 || @player1.won? || @player2.won?
    end

    @board.print_board
    puts 'Game over!'
    puts "Congratulations #{@is_player1_turn ? @player2.mark : @player1.mark} won"
  end
end
