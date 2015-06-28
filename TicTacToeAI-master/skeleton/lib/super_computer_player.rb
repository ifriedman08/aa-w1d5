require_relative 'tic_tac_toe_node'
require "byebug"

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)

    move = node.children.select { |child| child.winning_node?(mark) }.sample ||
           node.children.reject { |child| child.losing_node?(mark)  }.sample

    if move
      return move.prev_move_pos
    end


    raise "You shall not win!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
