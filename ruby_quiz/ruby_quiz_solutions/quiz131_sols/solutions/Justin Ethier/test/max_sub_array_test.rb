$:.unshift File.join(File.dirname(__FILE__), "..")
require 'test/unit'
require 'max_sub_array.rb'

class TestMaxSubArray < Test::Unit::TestCase
 def setup
   @ma = MaxSubArray.new
 end

 def test_max_sub_array
   assert_equal([2, 5, -1, 3], @ma.find([-1, 2, 5, -1, 3, -2, 1]))
   assert_equal([10], @ma.find([-1, 2, 5, -1, 3, -2, -12, 10]))
   assert_equal(@ma.find([-25, 81, -14, 43, -23, 86, -65, 48]), [81, -14, 43, -23, 86])
   assert_equal([9, 11, 23, -5, 15, 18, 6, -18, 21, -4,
                          -17, -19, -10, -9, 19, 17, 24, 10, 21, -23, -25,
                          21, -2, 24, -5, -4, -7, -3, -4, 16, -9, -18, -22,
                          -6, -19, 22, 18, 19, 22, -11, -3, 2, 21, 6, 10, 4,
                          2, -25, 5, -1, 20, 10, -16, 10, -2, -10, 23],
                @ma.find([-16, -8, 9, 11, 23, -5, 15, 18, 6, -18, 21, -4,
                          -17, -19, -10, -9, 19, 17, 24, 10, 21, -23, -25,
                          21, -2, 24, -5, -4, -7, -3, -4, 16, -9, -18, -22,
                          -6, -19, 22, 18, 19, 22, -11, -3, 2, 21, 6, 10, 4,
                          2, -25, 5, -1, 20, 10, -16, 10, -2, -10, 23, -23, 16,
                          -19, -10, 12, -17, -9, 6, -8, -23, 16, -17, -10, 24,
                          -1, -6, -24, -5, 16, -11, -7, -8, 12, -21, -23, -8,
                          -8, 4, 7, 6, -22, -8, -19, -7, 23, 4, 9, -19, -19, 0, -15]))
   assert_equal([13, 49, 23, 48, 10, 39, 20, -30, -14, 17, 26, 9, 30, 31, 16, 44, 20, 10, 55, 28,
                 -18, -30, 57, -32, -8, 5, -36, -6, -24, -39, -9, -17, 38, -5, -28, 45, -38, 4,
                 4, 41, 35, -5, 53, 29, 1, 21, 5, -39, -6, -21, -8, 32, -22, 8, 37, 57, 13, 17,
                 -17, 11, 18, -22, 9, -17, -26, -7, 50, -23, 30, -24, 34, -10, -26, -27, 12, 5, -2,
                 4, 54, 23, 20, -22, -10, 36, 56, -34, 31, -2, 26, 56, 10, -35, -29, 40, -1, 30, 45, 36],
                @ma.find([13, 49, 23, 48, 10, 39, 20, -30, -14, 17, 26, 9, 30, 31, 16, 44, 20, 10, 55, 28,
                 -18, -30, 57, -32, -8, 5, -36, -6, -24, -39, -9, -17, 38, -5, -28, 45, -38, 4,
                 4, 41, 35, -5, 53, 29, 1, 21, 5, -39, -6, -21, -8, 32, -22, 8, 37, 57, 13, 17,
                 -17, 11, 18, -22, 9, -17, -26, -7, 50, -23, 30, -24, 34, -10, -26, -27, 12, 5, -2,
                 4, 54, 23, 20, -22, -10, 36, 56, -34, 31, -2, 26, 56, 10, -35, -29, 40, -1, 30, 45, 36, -38, 30, -28]))
 end
end
