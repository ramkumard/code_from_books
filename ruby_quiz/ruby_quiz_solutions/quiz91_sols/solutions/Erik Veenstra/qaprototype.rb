module QAPrototype
  def method_missing(method_name)
    puts "#{method_name} is undefined"
    puts "Please define what I should do (end with a newline):"

    (code ||= "") << (line = $stdin.gets) until line and line.chomp.empty?

    self.class.module_eval do
      define_method(method_name){eval code}
    end

    at_exit do
      puts ""
      puts "class #{self.class}"
      puts "  def #{method_name}"
      code.gsub(/[\r\n]+$/, "").split(/\r*\n/).each{|s| puts " "*4+s}
      puts "  end"
      puts "end"
    end
  end
end
