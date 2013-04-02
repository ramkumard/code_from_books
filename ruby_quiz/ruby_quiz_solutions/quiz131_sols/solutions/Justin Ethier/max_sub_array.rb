# Object defining a sub-array of integer values
# The sub-array contains a start and end index
# defining a region of the master array
class SubArray
 def initialize
   @start = 0
   @end = 0
   @sum = 0
 end

 # Set boundaries of the sub-array
 def set_bounds(list_start, list_end)
   @start, @end = list_start, list_end
 end

 # Provide get/set accessors
 attr_reader :start, :end, :sum
 attr_writer :sum
end


class MaxSubArray
 # Finds the sub-array with the largest sum
 # Input: a list of integers
 def find(list)
   max = SubArray.new
   cur = SubArray.new

   for i in 0...list.size
     cur.sum = cur.sum + list[i]

     if (cur.sum > max.sum)
       max.sum = cur.sum
       cur.set_bounds(cur.start, i)
       max.set_bounds(cur.start, i)
     elsif (cur.sum < 0)
       # If sum goes negative, this region cannot have the max sum
       cur.sum = 0
       cur.set_bounds(i + 1, i + 1)
     end
   end

   list.slice(max.start, max.end - max.start + 1)
 end
end
