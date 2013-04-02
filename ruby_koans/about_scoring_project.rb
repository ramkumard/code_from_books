require File.expand_path(File.dirname(__FILE__) + '/edgecase')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
   # initialize the Hash containing the scores
   # and the default value is 0. 
  scores = Hash.new(0)
   # iterate on the array of dice (values (1..6))
  dice.each do |value|
     # for each value increment the corresponding
     # counter in the Hash.
    scores[value] += 1
     # in the end, scores contains the updated counter
     # for each number in the dice param.
     # default: 0.
  end
   # using reduce:
   #   reduce(initial, sym) -> obj
   #   reduce(sym) -> obj
   #   reduce(initial) {| memo, obj | block } -> obj
   #   reduce {| memo, obj | block } -> obj  
   # Combines all elements of enum by applying a binary operation,
   # specified by a block or a symbol that names a method or operator.
   #
   # If you specify a block, then for each element in enum the block
   # is passed an accumulator value (memo) and the element.
   # If you specify a symbol instead, then each element in the collection
   # will be passed to the named method of memo.
   # In either case, the result becomes the new value for memo.
   # At the end of the iteration, the final value of memo is 
   # the return value for the method.
   #
   # If you do not explicitly specify an initial value for memo, then 
   # uses the first element of collection is used as the initial 
   # value of memo. 
  scores.reduce(0) do |result, (key, value)|
      # 0:             the initial value
      # result:        the accumulator value (memo)
      # (key, value):  the obj
      # Inside the block two working variables are created and
      # are depending by the counter value of the key
    triple = value / 3      # a multiple of 3 is a triple
    remainer = value % 3    # dividing two integers may result in a remainder...
      # then the result is calculated
    result += (1000 * triple) + (100 * remainer) if key == 1
    result += (500 * triple) + (50 * remainer) if key == 5
    result += (100 * key) if (key != 1 && key != 5 && value >= 3)
      # and the result returned 
    result
      # very beautiful code.
  end
end

=begin

# mrjamesriley
def score(dice)
  score = 0
  1.upto(6).each do |num|
    amount = dice.count(num)
    if amount >= 3
      score += num == 1 ? 1000 : num * 100
      amount -= 3
    end
    score += 100 * amount if num == 1
    score += 50 * amount if num == 5
  end
  score
end

# cvortmann and tanob:
def score(dice)
  scores = Hash.new 0
  dice.each do |n|
    scores[n] += 1
  end
  scores.reduce(0) do |result, (key, value)|
    triplets, remainer = value / 3, value % 3
    result += (100 * remainer) + (1000 * triplets) if key == 1
    result += (50 * remainer) + (500 * triplets) if key == 5
    result += (100 * key) if (key != 1 && key != 5 && value >= 3)
    result
  end
end

=end

class AboutScoringProject < EdgeCase::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end
