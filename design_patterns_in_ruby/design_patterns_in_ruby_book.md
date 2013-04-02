
# Design Patterns In Ruby
 - http://designpatternsinruby.com/index.html


# The Article That Started It All
 - http://designpatternsinruby.com/section01/article.html

In Feburary 2006, with all of the excitement about Rails and Ruby just coming to a boil, I wrote a short article in my blog about, well, design patterns in Ruby. This caught the attention of a brilliant editor of very refined literary tastes over at Addison-Wesley (Hi Chris!), and the rest, as they say, is history.

Looking back on that original article makes me shiver a little bit (hint: I got some things wrong). In any case, you can read the original over at my blog at www.russolsen.com, or you can just scroll down:
Design Patterns in Ruby
MONDAY FEB 27, 2006

A former colleague of mine used to say that thick books about design patterns were evidence of an inadequate programming language. What he meant was that, since design patterns are the common idioms of code, a good programming language should make them very easy to implement. An ideal language would so thoroughly integrate the patterns they they would almost disappear from sight.

To take a sort of extreme example, in the late 80’s I worked on a project that produced object oriented code in C. Yes, C, not C++. We pulled this off by having each “object” (actually a C structure) point off to a table of function pointers. We operated on our “objects” by chasing the pointer to the table and calling functions out of the table, thereby simulating a method call on an object. It was awkward and messy, but it worked. Had we thought of it, we might have called this technique the “object oriented” pattern. Of course with the advent of C++ and then Java, our object oriented pattern disappeared, absorbed so thoroughly into the language that it vanished from sight. Today, we don’t usually think of object orientedness as a pattern.

With this in mind, and the intense interest in Ruby these days, let’s have a look at how we might implement some of the more common design patterns from the GOF book (Design Patterns: Elements of Reusable Object-Oriented Software Gamma, Helm, Johnson, & Vlissides) in Ruby.
Singleton

First off, let’s look at the pattern everyone loves to hate, the Singleton. Here is a singleton written by hand in Ruby:

```
class OnlyMe

  @@the_instance = nil

  def OnlyMe.instance
    if not @@the_instance
      @@the_instance = OnlyMe.new
    end
    @@the_instance
  end

  # Other methods...

end
```

This works about the same as it would in Java: there is a class variable (in this case the_instance) which holds a reference to the singleton. The singleton is created the first time someone asks for it. In order to get the single instance of OnlyMe, you would simply code:

```
only_me = OnlyMe.instance
```

One problem with my OnlyMe class is that it is not thread safe; a second thread coming in could easily trigger the creation of a second instance of OnlyMe. Also, there is nothing in my code to prevent someone from creating a second instance of OnlyMe with the plain old constructor. I could continue on and fix all of these problems in the code above, but in real life you would not create a singleton by hand in Ruby; you would just use the Singleton mix in, part of the Ruby standard library:

```
require 'singleton'

class OnlyMe
  include Singleton

  # Other methods...
end

only_me = OnlyMe.instance
```

A key thing to note is that the Singleton mix in not only adds in the “instance” method and the thread safe code to get the instance created, but it also makes the OnlyMe constructor private, and so ensures that no one can create a second instance by accident. There is something satisfying about having all that singleton infrastructure disappear behind the single “include Singleton” statement.
Factories

The GOF book describes a number of different factory patterns, all with the goal of isolating the code that needs to create a class from the concrete implementation of that class. In other (Java) words, if I need a new IGear, it might be better if I didn’t know if I was creating a com.spacely.Sprocket, or a or a com.coswell.Cog. So I might use the FactoryMethod pattern to solve this problem. Instead of committing myself to a particular IGear implementation, I pass around a separate object which knows how to create our gear. Here it is in Java:

```
interface IGearFactory {
  IGear createGear();
}

class ConcreteGearFactory  implements IGearFactory{
  IGear createGear() {
    if ( ... some condition... )
       return new Sprocket();
    else
       return new Cog();
}

class GearUser {

  public void doSomething(IGearFactory factory ) {
    ...
    IGear my_gear = factory.createGear();
    ...
  }
}
```

All very familiar stuff, and we could do something very similar (sans interface and declarations) in Ruby:

```
class GearFactory
  def createGear() 
    if ( ... some condition... )
       return Sprocket.new
    else
       return Cog().new
    end
  end
end

class GearUser 
  def doSomething(factory )
    ...
    my_gear = factory.createGear()
    ...
  end
end
```

But consider that in Ruby, everyday objects are created by calling the new method on a class. For example, we might create a new instance of the class Array with:

```
my_array = Array.new()
```

Now since there is really nothing special about a class object like Array in Ruby – it’s just another object, and there is nothing special about the new method in Ruby – it’s just another method, we can rename our factory method to be called new:

```
class GearFactory
  def new() 
    if ( ... some condition )
       return Sprocket.new()
    else
       return Cog().new()
    end
  end
end
```

Our client class now becomes:

```
class GearUser 
  def doSomething(factory )
    ...
    my_gear = factory.new()
    ...
  end
end
```

Now here is the punchline: our client class no longer has to distinguish between a factory and an ordinary class. All three of the following statements are will work:

```
client.doSomething(GearFactory.new)          # Use the factory
client.doSomething(Cog)                      #Use the Cog class
client.doSomething(Sprocket)                 #Use the Sprocket class
```

Essentially, from the point of view of the client, the difference between a factory method and an ordinary class has vanished. The client doesn’t care; it just calls the new method on the object passed in and gets a new instance of a gear object. If the object with the new method is a class, fine. If not, fine too.
Iterators

I’m teaching a weekly class in Ruby, and nothing has given my very Java savvy students more pain than Ruby code blocks. A Ruby code block is a chunk of code that you can pass around more or less like an object. For example, Ruby arrays have a method called each which takes a code block and executes it for each element in the array:

```
a = [ 10, 20, 30, 40 ]

a.each { |element| print "The element is #{element}\n" }
```

The part between the curly braces is the code block, which in this example gets called four times, once for each element in the array. Now if you think about it, this is the Iterator pattern. Our code is getting called once for each element in some data structure, in this case an array. There is no reason why we couldn’t do the same trick with other, possibly much more complex data structures, and indeed we see it over and over in the Ruby standard library. Among my favorites are iterating over every line in a file:

```
open("data.txt").each_line { |line| print "The line is #{line}\n" }
```

... and over all the live threads:

```
Thread.list.each { |t| print "Thread: #{t}\n" }
```

... and best of all, iterating over every object in the system:

```
ObjectSpace.each_object { |o| print "Object: #{o}\n" }
```

While all of the examples above are instances of the iterator pattern, the naturalness and ease of coding makes the “patternness” fade into the background.
Compressibility and Ideas Per Line

In all of these examples, we see what I think of as concept compressibility. In Ruby, like Java, you can implement very sophisticated ideas. But with Ruby it is possible to hide the details of your implementations much more effectively. You can make a class a singleton with a simple “include Singleton”. You can make factories that look exactly like ordinary classes. You can define visitors with a couple of curly braces. All of this allows you to compress out the details and simply say more interesting things in each line of code.

This is not just a question of keyboard laziness, it is an application of the DRY (Don’t Repeat Yourself) principal. I don’t think anyone would argue that it is a good thing that my old object oriented pattern in C has faded away – it worked for me, but it made me work for it, too. In the same way, the Java version of many of the GOF patterns work, but they make you work too. It would be a real step forward if we can do that work only once and compress it out of the bulk of our code.

Russ Olsen

# The code from the book

You can download the zip file containing all of the code from the book. The zip file is organized by chapter, one subdirectory per chapter. In each subdirectory you will, for the most part, find Ruby files with names like ex1_report.rb or ex15_subclass_test.rb or ex13_account_demo.rb.

The files are numbered so as to roughly follow the order that the code appears in the book. For example, chap01/ex3_vehicle.rb appears in the book before chap01/ex8_delegate.rb.

The files whose names end with “demo” are a bit special. These guys contain the code for the fragmentary, inline examples (as opposed to full classes) that are sprinkled throughout the book – take a look at the code on page 6. These “demo” files actually make use of a couple of utility methods found in the “example.rb” in the root code directory.

The problem I had with fragmentary examples was that I wanted to be sure that the code actually worked, and that the output that I claimed the code produced actually came out of the code, no small feat when you are dealing with more than 100 separate examples. The solution that I came up with was to wrap each little example in a call to a method (defined in example.rb) called example:

```
example %q{
my_car = Car.new
my_car.drive(200)

}
```

Look closely at the code above and you will see that the example code gets passed to the example method as a string. The example method does two things with that string: first it simply prints it out (so that I could snag the code for inclusion in the book) and then executes it (so that I could snag the output for inclusion in the book). Ah the wonders of Ruby!

Finally, there are a couple of examples in the later parts of the book which just didn’t fit into the ex##_*.rb naming scheme, but these should be pretty self explanatory.

Of course if you have any questions or comments, just email me at russ funny at sign russolsen dot com.

