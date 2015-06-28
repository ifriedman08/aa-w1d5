

class PolyTreeNode
  attr_reader :value, :parent, :children


  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    return if parent == new_parent

    parent.children.delete(self) unless parent.nil?
    @parent = new_parent
    parent.children << self unless parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "It aint my child" unless children.include?(child)
    child.parent = nil
  end

  def dfs(target)
    return self if self.value == target
    children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current = queue.shift
      return current if current.value == target
      queue += current.children
    end
    nil
  end

  def trace_path_back
    path = []
    current_node = self
    until current_node.parent.nil?
      path << current_node.value
      current_node = current_node.parent
    end
    path << current_node.value
    path.reverse
  end

end
