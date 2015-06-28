require_relative 'polytreenode.rb'
require "byebug"

class KnightPathFinder
  attr_reader :board

  def initialize(start_pos)
    @start_pos = start_pos
    @board = Array.new(8) {Array.new(8)}
    @visited_pos = [start_pos]
    @root = PolyTreeNode.new(start_pos)
  end

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos, value)
    x, y = pos
    board[x][y] = value
  end

  def self.valid_moves(pos)
    x,y = pos
    result = []
    [-2, 2].each do |first|
      [-1, 1].each do |second|
        result << [x + first, y + second]
        result << [x + second,y + first]
      end
    end
    result.select {|pos| pos.all? {|num| num.between?(0,7)}}
  end

  def new_move_positions(pos)
    result = self.class.valid_moves(pos).select do |new_pos|
      !visited_pos.include?(new_pos)
    end

    @visited_pos += result
    result
  end


  def build_move_tree
    queue = [@root]

    until queue.empty?
      current_node = queue.shift
      positions = new_move_positions(current_node.value)

      positions.each do |child_pos|
        current_child = PolyTreeNode.new(child_pos)
        current_node.add_child(current_child)
        queue << current_child
      end
    end
  end

  def find_path(target)
    found_node = @root.dfs(target)
    found_node.trace_path_back
  end



  private
    attr_reader :start_pos
    attr_accessor :visited_pos
end


kfp = KnightPathFinder.new([0,0])
kfp.build_move_tree
p kfp.find_path([7,7])
