### getting words from the list in word.lst
# assuming that each word in the file is on a different line
# and using the Unofficial Jargon File Word Lists from http://wordlist.sourceforge.net
#
f = File.open("word.lst", "r")
fi = f.read.gsub("\n", " ").scan(/\w+/).to_a
f.close
allwords = Array.new
fi.each {|word| (if ((word.length >= 3) and (word.length <= 6))
                    allwords << word.upcase
                 end)
}
## now they're all in an array
bwords = Array.new
  allwords.each {|word| (if (word.scan(/./).length == 6) 
                  bwords << word
                 end) 
  }
  bwords.collect{|c| c.upcase!}


# code above sorts words with 6 letters into bwords

i = 1
score = 0
star = ""
while (i == 1) do
  puts "Pick a number between 0 and " + bwords.length.to_s + " or press Enter to end game."
  m = gets.chop
  if (m != "")
    n = m.to_i
    wordie = bwords[n].scan(/./).sort_by{rand}.to_s.upcase # word scramble
   
    puts "You have chosen the word: "  + wordie
    foo = 0
    all = allwords.dup
    while (foo == 0)
 
      puts "Form words! Type 0 to pick another word."
 
      guess = gets.chop.upcase
      o = 0
      while (o < guess.length) # tests if the letters used are legal
        guessy = guess.dup
        bwords[n].scan(/./).collect{|e| (guessy = guessy.sub(e , ""))}
        o += 1
        
      end
        if guessy == ""
          if (all.include? guess) # tests if the guess is in the wordlist
              all.delete(guess)
              score += guess.length
              puts "Your score is now: " + score.to_s  
          
               if (guess == bwords[n]) #tests and rewards if the guess is the original word
                 star << "*"
                 foo = 1337
                 puts " and you have " + star + " stars."
               end
          elsif (guess == "EXIT0")
             foo = 1337
          else
            puts "Incorrect! Try Again!"
          end
        
        elsif (guess == "EXIT0")
          foo = 1337
        else 
         puts "The letters used were illegal. Try again."
        end  
    

    end
    bwords.delete_at(n)
  else 
    i = 0
    puts "Your final score was: " + score.to_s + " and you have gathered " + star + " stars. (One star for each original 6 letter word found.)"
  end
end














