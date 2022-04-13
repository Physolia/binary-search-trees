# frozen_string_literal: true

class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

  # turns the array into a balanced binary search tree full of 'Node' objects that are appropriately placed
  # Returns the level 1 root node (array has to be sorted and without duplicates)
  
  def build_tree(array)
    return nil if array.empty?

    mid = (array.size - 1) / 2
    root_node = Node.new(array[mid])
    root_node.left = build_tree(array[0...mid])
    root_node.right = build_tree(array[(mid + 1)..-1])
    root_node
  end

  # Accepts a value you insert. Returns nil if the value already exists.

  def insert(value, node = root)
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  # Accepts a value to delete

  def delete(value, node = root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # This is if the ndoe has one or no children
      return node.left if node.right.nil?
      return node.right if node.left.nil?

      # This is if the node has two children
      leftmost_node = leftmost_leaf(node.right)
      node.data = leftmost_node.data
      node.right = delete(leftmost_node.data, node.right)
    end
    node
  end

  # Returns the node with it's given value. Returns nil if the node is not found.

  def find(value, node = root)
    return node if node.nil? || node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  # Returns an array of values traversing the tree using a 'Breadth First' search

  def level_order(node = root, queue = [])
    print "#{node.data} "
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    return if queue.empty?

    level_order(queue.shift, queue)
  end

  # These next 3 mothods return an array of values traversing the tree using a 'Depth First' search

  def pre_order(node = root)
    # Root Left Right
    return if node.nil?

    print "#{node.data} "
    pre_order(node.left)
    pre_order(node.right)
  end

  def in_order(node = root)
    # Left Root Right
    return if node.nil?

    in_order(node.left)
    print "#{node.data} "
    in_order(node.right)
  end

  def post_order(node = root)
    # Left Right Root
    return if node.nil?

    post_order(node.left)
    post_order(node.right)
    print "#{node.data} "
  end

  # Accepts a node & returns the height. Returns -1 if the node doesn't exist.
  # Height: The number of edges to the lowest leaf in it's subtree

  def height(node = root)
    unless node.nil? || node == root
      node = (node.instance_of?(Node) ? find(node.data) : find(node))
    end

    return -1 if node.nil?
    [height(node.left), height(node.right)].max + 1
  end

  # Accepts a nide & returns it's depth. Returns -1 if the node doesn't exist.
  # Depth: Number of edges from the root to the given node.

  def depth(node = root, parent = root, edges = 0)
    return 0 if node == parent
    return -1 if parent.nil?

    if node < parent.data
      edges += 1
      depth(node, parent.left, edges)
    elsif node > parent.data
      edges += 1
      depth(node, parent.right, edges)
    else
      edges
    end
  end

  # Checks if the tree is balanced. The difference between the heights of the left subtree & right subtree of every node is not more than 1
  
  def balanced?(node = root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
    
    false
  end

  # This balances an unbalanced tree.

  def rebalance
    self.data = inorder_array
    self.root = build_tree(data)
  end

  # Visualizing the binary search tree.

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│ ' : ' '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? ' ' : '│ '}", true) if node.left
  end

  private

  # Our helper method that finds the left most leaf

  def leftmost_leaf(node)
    node = node.left until node.left.nil?

    node
  end


  # Creates an inorder array of the tree

  def inorder_array(node = root, array = [])
    unless node.nil?
      inorder_array(node.left, array)
      array << node.data
      inorder_array(node.right, array)
    end
    array
  end
end