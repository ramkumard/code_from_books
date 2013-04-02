#!/usr/local/bin/ruby -w

class WordChain
	@@dictionary = Array.new
	
	def self.distance( from, to )
		same = 0
		from.length.times { |index| same += 1 if from[index] == to[index] }
		from.length - same
	end
	
	def self.load_words( file, limit )
		limit = normalize_word(limit).length
		
		File.foreach(file) do |word|
			word = normalize_word(word)
			
			next unless word.length == limit
			
			@@dictionary << word
		end
		
		@@dictionary.uniq!
	end

	def self.normalize_word( word )
		normal = word.dup

		normal.strip!
		normal.downcase!
		normal.delete!("^a-z")

		normal
	end
	
	def initialize( start, finish )
		@start  = self.class.normalize_word(start)
		@finish = self.class.normalize_word(finish)
		
		@chain = nil
	end
	
	attr_reader :start, :finish, :chain
	
	def link
		chains = Array[Array[@start]]

		until chains.empty? or
		      self.class.distance(chains.first.last, @finish) == 1
			chain = chains.shift
			links = @@dictionary.select do |word|
				self.class.distance(chain.last, word) == 1 and 
				not chain.include? word
			end
			links.each { |link| chains << (chain.dup << link) }
			
			chains = chains.sort_by do |c|
				c.length + self.class.distance(c.last, @finish)
			end
		end
		
		if chains.empty?
			@chain = Array.new
		else
			@chain = (chains.shift << @finish)
		end
	end
	
	def to_s
		link if @chain.nil?
		
		if @chain.empty?
			"No chain found between #{@start} and #{@finish}."
		else
			@chain.join("\n")
		end
	end
end

if __FILE__ == $0
	dictionary_file = "/usr/share/dict/words"
	if ARGV.size >= 2 and ARGV.first == "-d"
		ARGV.shift
		dictionary_file = ARGV.shift
	end

	unless ARGV.size == 2 and ARGV.first != ARGV.last and
	       ARGV.first.length == ARGV.last.length
		puts "Usage:  #{File.basename($0)} [-d DICTIONARY] START_WORD END_WORD"
		exit
	end
	start, finish = ARGV

	warn "Loading dictionary..." if $DEBUG
	WordChain.load_words(dictionary_file, start)
	warn "Building chain..." if $DEBUG
	puts WordChain.new(start, finish)
end
