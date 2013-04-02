require 'rubygems'
require 'text'
include Text::Metaphone


#use this to do the double_metaphone as a drop-in replacement for metaphone
def dmetaphone word 
  first,second = double_metaphone word
  second || first
end


#this solution gets 3 of the test cases correct if single metaphone is used
#it gets 10 of the test cases correct if double-metaphone is used, but also
#provides a much longer list of wrong answers for everything
#
#use this alias to set the particular phonetic conversion algorithm
alias_method :phonetic_convert, :dmetaphone


NUMBERS=Hash.new{|h,k| k}.merge!({"1"=>"one", "2"=>"two", "3"=>"three",
  "4"=>"four","5"=>"five","6"=>"six","7"=>"seven","8"=>"eight","9"=>"nine"})

DICT=open('/usr/share/dict/words') do |f|
  d=Hash.new{|h,k| h[k]=[]}
  f.each_line do |word|
    word=word.chomp
    d[phonetic_convert(word).gsub(/\s/,'')] << word
  end
  d
end

def rebus words
  words=words.collect{|x| NUMBERS[x]}.join(' ')
  DICT[phonetic_convert(words).gsub(/\s/,'')]
end

#tests given by steve d <oksteve@yahoo.com>
expectations = {
  %w[e scent shells] => 'essentials',
  %w[q all if i] => 'qualify',
  %w[fan task tick] => 'fantastic',
  %w[b you tea full] => 'beautiful',
  %w[fun duh mint all] => 'fundamental',
  %w[s cape] => 'escape',
  %w[pan z] => 'pansy',
  %w[n gauge] => 'engage',
  %w[cap tin] => 'captain',
  %w[g rate full] => 'grateful',
  %w[re late shun ship] => 'relationship',
  %w[con grad yeul 8] => 'congratulate',
  %w[con grad yule 8 shins] => 'congratulations', #from Phrogz
  %w[2 burr q low sis] => 'tuberculosis',
}

expectations.each do |words,target|
  result=rebus(words)
  if result.include?(target)
    printf "%s correctly gave %s.\n", words.inspect, target
  else
    printf "%s incorrect. Expected %s.\n", words.inspect, target
  end
  printf "Metaphone of words: %s   Metaphone of target: %s\n",
    phonetic_convert(words.collect{|x| NUMBERS[x]}.join(' ')),
    phonetic_convert(target)
  printf "Matching words %s\n", result.inspect
end
