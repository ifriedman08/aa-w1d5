require_relative 'tic_tac_toe.rb'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return true if @board.winner == opponent(evaluator)
      return false
    end


    if evaluator == next_mover_mark
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
  if @board.over?
    return true if @board.winner == evaluator
    return false
  end

    if evaluator == next_mover_mark
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  def children
    empty_spots = []
    (0..2).each do |row|
      (0..2).each do |spot|
        empty_spots << [row, spot] if @board.empty?([row, spot])
      end
    end

    result = empty_spots.map do |spot|
      temp_dup = @board.dup
      temp_dup[spot] = next_mover_mark
      TicTacToeNode.new(temp_dup, opponent(next_mover_mark), spot)
    end

    result
  end

  def opponent(evaluator)
    evaluator == :x ? :o : :x
  end
end
