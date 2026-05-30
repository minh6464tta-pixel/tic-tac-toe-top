# Player
class Player
  attr_reader :moves, :mark, :win_hash

  DIAGONAL1 = %w[a1 b2 c3].freeze
  DIAGONAL2 = %w[c1 b2 a3].freeze

  def initialize(mark)
    @moves = []
    @mark = mark
    @win_hash = Hash.new(0)
  end

  def self.map_move(move)
    rank = '2' if move[0] == 'a'
    rank = '1' if move[0] == 'b'
    rank = '0' if move[0] == 'c'
    rank + move[1]
  end

  def log_move(move)
    @moves.push(move)
    @win_hash[move[0]] += 1
    @win_hash[move[1]] += 1
    @win_hash[:diagonal1] += 1 if DIAGONAL1.include?(move)
    @win_hash[:diagonal2] += 1 if DIAGONAL2.include?(move)
  end

  def make_move
    puts "#{mark}'s turn. Make a move: "
    move = gets.chomp.downcase
    log_move(move) # log_move
    move
  end

  def won?
    win_hash.any? { |_, count| count >= 3 }
  end
end
