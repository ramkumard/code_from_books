#!/usr/bin/env ruby -wKU

require "test/unit"

require "avl_tree"

class TestAVLTree < Test::Unit::TestCase
 def setup
   @tree = AVLTree.new
 end

 def test_tree_membership
   assert_equal(true,  @tree.empty?)
   assert_equal(false, @tree.include?(3))

   @tree << 3

   assert_equal(false, @tree.empty?)
   assert_equal(true,  @tree.include?(3))
 end

 def test_tree_should_allow_more_than_one_element
   @tree << 3
   @tree << 4

   assert(@tree.include?(4))
   assert(@tree.include?(3))
 end

end
