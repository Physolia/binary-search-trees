# frozen_string_literal: true

require_relative 'node.rb'
require_relative 'tree.rb'

nomi_array = Array.new(15) { rand(1..100) }
bst = Tree.new(nomi_array)

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Level order traversal: '
puts bst.level_order

puts 'Preorder traversal: '
puts bst.pre_order

puts 'Inorder traversal: '
puts bst.in_order

puts 'Postorder traversal: '
puts bst.post_order

10.times do
  a = rand(100..150)
  bst.insert(a)
  puts "Inserted #{a} to tree."
end

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Rebalancing tree...'
bst.rebalance

bst.pretty_print

puts bst.balanced? ? 'Your Binary Search Tree is balanced.' : 'Your Binary Search Tree is not balanced.'

puts 'Level order traversal: '
puts bst.level_order

puts 'Preorder traversal: '
puts bst.pre_order

puts 'Inorder traversal: '
puts bst.in_order

puts 'Postorder traversal: '
puts bst.post_order