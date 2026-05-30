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

  def wins(player)
    puts 'Game over'
    puts "#{player.mark} won"
    @is_over = true
  end

  def draw
    puts 'Game over'
    puts "It's a draw"
    @is_over = true
  end

  def check_game_over
    if @moves.length == 9
      draw
    elsif @player1.won?
      wins(@player1)
    elsif @player2.won?
      wins(@player2)
    end
  end

  def play
    until @is_over
      @board.print_board
      if @is_player1_turn
        move(@player1)
      else
        move(@player2)
      end
      @is_player1_turn = !@is_player1_turn
      check_game_over
    end
    @board.print_board
  end
end
