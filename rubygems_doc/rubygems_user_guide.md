= RubyGems User Guide

 RubyGems is the premier ruby packaging system. It provides:

 * A standard format for distributing Ruby programs and libraries. * An easy to
 use tool for managing the installation of gem packages. * A gem server utility
 for serving gems from any machine where RubyGems is installed. * A standard way
 of publishing gem packages.

== Introduction to RubyGems

=== Really Quick Start

 <b>Question:</b> <em>I've installed RubyGems and I want to install Rails (for
 example). How do I do that?</em>

 <b>Answer:</b>

 <code>gem install rails</code>

=== What is a Gem?

 A gem is a packaged Ruby application or library. It has a name (e.g.
 <b>rake</b>) and a version (e.g. <b>0.4.16</b>).

 Gems are managed on your computer using the <tt>gem</tt> command. You can
 install, remove, and query (amoung other things) gem packages using the
 <tt>gem</tt> command.

 RubyGems is the name of the project that developed the gem packaging system and
 the <tt>gem</tt> command. You can get RubyGems from the main
 "rubygems.org":http://rubygems.org repository, or the old
 "RubyForge":http://rubyforge.org/projects/rubygems repository.

=== About This Document

 This document demonstrates the the use of the most important features of
 RubyGems in a quick and high-level way. It is designed to be read all the way
 through to give the reader a feeling for this technology. More detailed
 information is available in the "gem command
 reference":http://docs.rubygems.org/read/book/2.

=== About RubyGems

 h3. RubyGems Features

 * Easy Installation and removal of RubyGems packages and their dependents. *
 Management and control of local packages * Package dependency management *
 Query, search and list local and remote packages * Multiple version support for
 installed packages * Web-based interface to view the documentation for your
 installed gems * Easy to use interface for building gem packages * Simple
 server for distributing your own gem packages * Easy to use building and
 publishing of gem packages

 h3. RubyGems Benefits

 Using RubyGems, you can: * download and install Ruby libraries easily * not
 worry about libraries A and B depending on different versions of library C *
 easily remove libraries you no longer use * have power and control over your
 Ruby platform!

 It's the way it _should_ be.

== Using RubyGems

=== Basic Gem Usage

 This chapter gives examples of the most common user opertions performed with
 the <tt>gem</tt> command. See the "gem Command
 Reference":http://docs.rubygems.org/read/book/2 manual for details about
 particular gem commands.

 Versioning is a pretty basic concept in RubyGems. You might want to glance at
 the "Specifying Versions":/read/chapter/16 chapter for a better understanding
 of how versions work with RubyGems.

=== Listing remotely installable gems

 When you run

 <pre>gem query --remote # shortcut: gem q -R</pre>

 you see will a detailed list of all the gems on the remote server.

 Sample output (heavily abbreviated):

 <pre> *** REMOTE GEMS ***

 activerecord (0.8.4, 0.8.3, 0.8.2, 0.8.1, 0.8.0, 0.7.6, 0.7.5) Implements the
 ActiveRecord pattern for ORM.

 BlueCloth (0.0.4, 0.0.3, 0.0.2) BlueCloth is a Ruby implementation of Markdown,
 a text-to-HTML conversion tool for web writers. Markdown allows you to write
 using an easy-to-read, easy-to-write plain text format, then convert it to
 structurally valid XHTML (or HTML).

 captcha (0.1.2) Ruby/CAPTCHA is an implementation of the 'Completely Automated
 Public Turing Test to Tell Computers and Humans Apart'.

 cardinal (0.0.4) Ruby to Parrot compiler.

 cgikit (1.1.0) CGIKit is a componented-oriented web application framework like
 Apple Computers WebObjects. This framework services Model-View-Controller
 architecture programming by components based on a HTML file, a definition file
 and a Ruby source.

 progressbar (0.0.3) Ruby/ProgressBar is a text progress bar library for Ruby.
 It can indicate progress with percentage, a progress bar, and estimated
 remaining time.

 rake (0.4.0, 0.3.2) Ruby based make-like utility. </pre>

 The _progressbar_ gem is a nice and simple utility that we will use to
 demonstrate further features.

=== Searching remotely installable gems

 When you run

 <pre> gem query --remote --name-matches doom # shortcut: gem q -R -n doom</pre>

 you will see a detailed list of _matching_ gems on the remote server.

 Sample output:

 <pre> *** REMOTE GEMS ***

 ruby-doom (0.8, 0.0.7) Ruby-DOOM provides a scripting API for creating DOOM
 maps. It also provides higher-level APIs to make map creation easier. </pre>

=== Installing a remote gem

 When you run (as root, if appropriate and necessary)

 <pre>gem install --remote progressbar # shortcut: gem i -r progressbar</pre>

 the _progressbar_ gem will be installed on your computer. Notice that you don't
 need to specify the version, but you can if you want to. It will default to the
 last version available.

 <pre>gem ins -r progressbar-0.0.3</pre>

 or

 <pre>gem ins -r progressbar --version '> 0.0.1'</pre>

 In both cases, the output is simply:

 Attempting remote installation of 'progressbar' Successfully installed
 progressbar, version 0.0.3

 RubyGems allows you to have multiple versions of a library installed and choose
 in your code which version you wish to use.

 Useful extra options for installation are <tt>--gen-rdoc</tt> for generating
 the gem's RDoc API documentation, and <tt>--run-tests</tt> to run the gem's
 unit tests, if any.

 Note too that when you remotely install a gem, it will download and install any
 specified dependencies. Try installing *copland* and see that it prompts you to
 accept *log4r* as well (if it's not already installed).

=== Looking at an installed gem

 When you run

 <pre>gem specification progressbar # shortcut: gem spec progressbar</pre>

 you will see all the details of the ''progressbar'' gem.

 Sample output:

 <pre> --- !ruby/object:Gem::Specification rubygems_version:"1.0\" name:
 progressbar version: !ruby/object:Gem::Version version: 0.0.3 date: 2004-03-20
 20:03:00.679937 +11:00 platform: summary: "Ruby/ProgressBar is a text progress
 bar library for Ruby. It can indicate progress with percentage, a progress bar,
 and estimated remaining time." require_paths: - lib files: - sample/test.rb -
 lib/progressbar.rb - docs/progressbar.en.rd - docs/progressbar.ja.rd -
 ChangeLog autorequire: progressbar author: Satoru Takabayashi email:
 satoru@namazu.org homepage: http://namazu.org/~satoru/ruby-progressbar/ </pre>

 Some interesting information includes the author's details, the version and
 description of the gem.

 There is also important technical information for RubyGems to use this gem
 properly. This includes the list of files included, where to include files
 from, and what to require by default (more on this later).

=== Uninstalling a gem

 If we've finished with *progressbar*, we can uninstall it.

 <pre>gem uninstall progressbar</pre>

 Sample output:

 <pre>Successfully uninstalled progressbar version 0.0.3</pre>

 If there are more than one version of a gem installed, the gem command will ask
 you which version to delete.

 If there are other gems that depend upon the gem being uninstalled, and if
 there is no other way to satisfy that dependency, then the user will be will be
 given a warning and allowed to cancel the uninstall.

=== Listing all installed gems

 It's easy:

 <pre>gem query --local # shortcut: 'gem q -L'</pre>

=== A note on local and remote operations

 You've no doubt noticed the <tt>--local</tt> and <tt>--remote</tt> options on
 most of the command lines shown so far. If you don't specify either of these,
 then <tt>gem</tt> will (usually) try ''both'' a local and remote operation. For
 example:

 gem ins rake # Attempt local installation; go remote if necessary gem list -b
 ^C # List all local AND remote gems beginning with "C"

=== Browsing all installed gems and their documentation

 You can run your own gem server. This means other people can (potentially)
 install gems ''from your computer''. And as a side-effect of that, you can view
 your installed gems through your web browser. Just run

 <pre>gem server</pre>

 and point your browser to
 <tt>"http://localhost:8808":http://localhost:8808</tt>.

 You'll be able to view the documentation for each gem, as long as you asked for
 it to be generated when you installed it.

=== Using a config file

 If you want to always generate RDoc documentation and run unit tests for each
 gem you install, then you can specify these command-line options in a config
 file (<tt>.gemrc</tt> in your home directory).

 <pre>gem: --rdoc --test</pre>

 There are other things you can achieve with a config file (RDoc parameters,
 GEMPATH settings). See `gem help env` for the details.

=== Other features

 <tt>gem check --alien</tt> will report on any rogue (unmanaged) files in the
 RubyGems repository area.

 <tt>gem check --verify progressbar</tt> will check that the installed
 ''progressbar'' gem is valid against its own checksum.

== Installing RubyGems

=== Installing RubyGems

 Get it from "RubyForge":http://rubyforge.org/frs/?group_id=126
 (http://rubyforge.org/frs/?group_id=126) and run (as root, if appropriate and
 necessary)

 <pre>ruby setup.rb</pre>

 It's easy. It installs the required library files and the *gem* command. This
 command gives us the power to do everything else in this document, except
 distribute gems (for now!).

 *Debian and Ubuntu*: Debian and Ubuntu do not automatically include all the
 standard Ruby libararies in the basic Ruby package. As a result, you may need
 to ''apt-get'' libyaml-ruby and libzlib-ruby before you can install rubygems.
 Additionally, you may need to install ruby-dev in order to install gems that
 have C extensions. Commonly these platforms now have a "ruby-full" package that
 will install most of the common libraries.

=== Installing RubyGems in a User Directory

 If a user does not have access to the standard installation location (typically
 @/usr/local/lib/ruby@), then they have the option of installing RubyGems in a
 alternate location.

 Note that if you can't install RubyGems in the standard location, then you
 probably can't install gems in the standard gem repository location either. You
 need to specifiy a non-standard gem repository location via the GEM_HOME
 environment variable.

 Use the following to install RubyGems in a user directory (here called
 @/home/mystuff@) with a repository named @/home/mygemrepository@):

 <pre> $ export GEM_HOME=/home/mygemrepository $ ruby setup.rb
 --prefix=/home/mystuff </pre>

 *Notes:* # The @export@ command is shell specific. Use the appropriate command
 for your OS and shell. For example windows users would probably say:

 <pre>set GEM_HOME=/home/mygemrepository</pre> # Make sure you add
 @/home/mystuff/bin@ to your path so that the @gem@ command can be found. # Make
 sure you add the @GEM_HOME@ setup to your profile, so that RubyGems can find
 the location of your gem repository. # If you want the gem repository to reside
 inside the install directory, we recommend setting @GEM_HOME@
 _prefix_dir_/@gems@. (where _prefix_dir_ is given as the valud of @--prefix@ in
 the config step)

=== Updating RubyGems

 h3. Modern Versions of RubyGems

 If your RubyGems version is 0.8.5 or later, you can upgrade to the latest
 version with:

 <pre> gem update --system </pre>

 Don't forget to use <tt>sudo</tt> if your system requires root access to
 install ruby libraries.

 h3. Prior to RubyGems 0.8.5 or RubyGems 1.2.0 (or "Nothing to Update")

 If your current version of RubyGems is older than version 0.8.5, or
 specifically RubyGems 1.2.0, or you see the message "Nothing to update" when
 you tried <tt>gem update --system</tt>, then use the following commands:

 <pre> gem install rubygems-update update_rubygems </pre>

 h3. Manual Upgrades

 Download the latest RubyGems tar or zip file and following the instructions for
 <em>"Installing RubyGems":http://docs.rubygems.org/read/chapter/3#page13</em>.

=== Post-install -- Setting Up the RubyGems Environment

 Now that you have RubyGems installed, you should be ready to run applications
 using gems, right?

 Well, almost.

 You have one more decision to make: How to let Ruby programs know to use the
 gems repository.

 You see, because the of versioned nature of the gems repository, RubyGems
 doesn't store the library files directly in standard library search path. It
 adds the necessary gem packages to the library seach path as needed at run
 time.

 This means that RubyGems must be loaded before any gem libraries are
 accessable.

 h3. Ruby 1.9

 The default Ruby 1.9 package now includes RubyGems by default on most platforms
 (presently Debian based systems split this out into a separate package). This
 means that on Ruby 1.9 and above, you will not need to <code>require
 'rubygems'</code> in order to load gem libraries.

 h3. The Hard Way

 The most direct way to make RubyGems available is to just require it in the
 source code:

 <pre> require 'rubygems' require 'some_gem_library' # ... </pre>

 The big problem with this approach is that you don't want to make this change
 to <em>every single Ruby program you download</em>! While ok for quick scripts
 you write yourself, this is not the way to go.

 h3. Using the @-rubygems@ Command Line Option

 To avoid modifying all the Ruby programs you install, you could tell the @ruby@
 interpreter to preload ruby gems before running other software. You can easily
 do this by giving the @ruby@ command a @-rubygems@ option each time you run a
 program.

 ruby -rubygems my_program_that_uses_gems

 This works, and avoids changing installed software, but is a pain to type all
 the time. Fortunately there is another option.

 h3. Using @RUBYOPT@

 By setting the @RUBYOPT@ environment variable to the value @rubygems@, you tell
 Ruby to load RubyGems every time it starts up. This is similar to the
 @-rubygems@ options above, but you only have to specify this once (rather than
 each time you run a Ruby script).

 Unix users will want to put the following line in their @.profile@ (or
 equivalent):

 export RUBYOPT=rubygems

 Windows users will want to set the RUBYOPT environment variable using the
 appropriate sysetm utility. (On XP you can find it under Settings / Control
 Panel / System. Click the advanced tab and then the "Environment Variables"
 button near the bottom. Note that the one-click installer will set up RUBYOPT
 for you automatically (unless you request it not be done).

 h3. The Future

 The need to preload the RubyGems software is one of the biggest drawbacks to
 RubyGems' versioned software approach. The RubyGems team is investigating ways
 of making this issue much less onerous.

 In the meantime, enjoy RubyGems.

== Coding With RubyGems

=== Using a gem in your code

 Here we demonstrate the use of the *progressbar* gem. This library may use
 terminal features that are not available in your system.

 If you wish, enter the following code into a file and run it. (Note that you
 must require the rubygems library before executing this code, as detailed in
 chapter 3 of this manual.)

 <pre> require 'progressbar'

 bar = ProgressBar.new("Example progress", 50) total = 0 until total >= 50
 sleep(rand(2)/2.0) increment = (rand(6) + 3) bar.inc(increment) total +=
 increment end </pre>

 Here is a "screenshot" of the partially complete progress bar.

 Example progr: 29% |ooooooooooo | ETA: 00:00:04

 The first line of the program requires the progressbar library file. RubyGems
 will look for the @progressbar.rb@ file in the standard library locations. If
 not found, it will look through its gem repository for a gem that contains
 @progressbar.rb@. If a gem is used, RubyGems attempts to use the latest
 installed version by default.

 Note that the program was able to use the latest available installed gem by
 default _without_ any explicit action in the code. The developer may develop a
 library without worrying about using RubyGems.

 However, to _run_ the code, the environment does need to be "gem enabled". See
 "Setting Up the RubyGems
 Environment":http://docs.rubygems.org/read/chapter/3#page70 for details on how
 to make this happen.

=== Using Explicit Versions

 The distinguishing feature of RubyGems is the ability to use versioned
 libraries when running an application. How do we take advantage of versioning.

 h3. Explicit Versioning

 To explicitly use a particular version of a library, you need to use the @gem@
 method. This method specifies the name of a gem package and the version you
 wish to have loaded.

 For example, suppose your application uses RedCloth, but needs a version of
 RedCloth in the 3.x series. You can include explcitly in your code:

 <pre> require 'rubygems' gem 'RedCloth', '~> 3.0' </pre>

 RubyGems will select the latest installed version of the RedCloth software that
 has a version number in the 3.x series. If no such software is found, a
 exception is generated.

 h3. Planning Ahead

 Rather than spread your version requirements all over your code, it is best to
 gather them in one location to make it easy to maintain.

 The Rails application framework is a good example. You will find an environment
 file in the config directory of any (recent) Rails application. The environment
 file, in part, contains the following lines:

 <pre> # ... require 'rubygems' require 'activesupport' require 'activerecord'
 require 'actionpack' require 'actionmailer' require 'actionwebservice' require
 'rails' # ... </pre>

 The lines will load the most recent available version of the Rails software.
 Note that they didn't need to use the @gem@ method above because @rubygems@ was
 required first, which automatically put the gems in their @$LOAD_PATH@.

 If the most current version is not appropriate (perhaps your ISP has upgraded
 to an incompatible version of Rails and you haven't converted your web app
 yet), then all you need to do is edit @environment.rb@ to be something like:

 <pre> # ... require 'rubygems' gem 'activerecord', '= 1.4.0' gem 'actionpack',
 '= 1.2.0' gem 'actionmailer', '= 0.5.0' gem 'rails', '= 0.9.3' # ... </pre>

 Now your webapp will use an older version of Rails without interfering with
 anyone else's use of the newer version.

== Specifying Versions

=== Basic Versions

 The concept of a version is central to the RubyGems packaging scheme. Every gem
 package is assigned a version string consisting of digits and periods (e.g.
 "@1.3.122@").

 The @gem@ command line program and the @gem@ Ruby command both take version
 constraint arguments. These arguments restrict the range of versions that are
 acceptable to the commands.

 For example, if you want in install verion 0.4.14 of the @rake@ gem, you can
 say:

 <pre> gem install --remote rake --version "0.4.14" </pre>

=== Advanced Versioning

 If you don't care about the _exact_ version of @rake@, but want to make sure
 you get something later than version 0.4.10, you can say:

 <pre> gem install --remote rake --version "> 0.4.10"</pre>

 In fact, any of the standard comparison operators can be used for the version
 constraint.

 Here are the available operators:

 <pre> = Equals version != Not equal to version > Greater than version < Less
 than version >= Greater than or equal to <= Less than or equal to ~>
 Approximately greater than (see "Pessimistic Version Constraint" below) </pre>

 Here are some examples:

 <pre> gem 'mygem', "> 1.1" gem 'yourgem', "= 4.56.4" </pre>

 If no version constraint operator is specified, RubyGems will assume that "="
 was intended.

=== Pessimistic Version Constraint

 If your project is using the "Rational Versioning Policy":/read/chapter/7 to
 assign version numbers, then your users can take advantage of that fact to
 carefully specify exactly what versions of your software should work with their
 system.

 For example, suppose you have the following releases ...

 * Version 2.1.0 -- Baseline * Version 2.2.0 -- Introduced some new (backward
 compatible) features. * Version 2.2.1 -- Removed some bugs * Version 2.2.2 --
 Streamlined your code * Version 2.3.0 -- More new features (but still backwards
 compatible). * Version 3.0.0 -- Reworked the interface. Code written to verion
 2.x _might_ not work.

 Your clients have validated that version 2.2.0 works with their software, but
 version 2.1.0 doesn't have a feature they need). Their require line would look
 like this ...

 <pre>gem 'library', '>= 2.2.0'</pre>

 This is called an OptimisticVersionConstraint. They are optimistic that the
 incompatible changes introduced in version 3.0 will still work with their
 software. They have no assurance of this (most likely verion 3.0 wasn't written
 when they wrote the gem line). But they are willing to take the chance.

 Some other clients of your library are not so hopeful. They fully expect that
 new interfaces will break their software, so they want to guard against
 accidently using the new interfaces. They use a PessimisticVersionConstraint
 that explicitly excludes your version 3.0.

 <pre>gem 'library', '>= 2.2.0', '< 3.0'</pre>

 Doing this is cumbersome, so RubyGems provides a pessimistic operator ~> (read:
 approximately greater than). Using the pessimistic operator, we get:

 <pre>gem 'library', '~> 2.2'</pre>

 Notice that we only include 2 digits of the version. The operator will drop the
 final digit of a version, then increment the remaining final digit to get the
 upper limit version number. Therefore <tt>'~> 2.2'</tt> is equivalent to:
 <tt>['>= 2.2', '< 3.0']</tt>. Had we said <tt>'~> 2.2.0'</tt>, it would have
 been equivalent to: <tt>['>= 2.2.0', '< 2.3.0']</tt>. The last digit specifies
 the level of granularity of version control. (Remember, you can alway supply an
 explicit upper limit if the pessimistic operator is too limited for you).

== Versioning Policies

=== What's a Versioning Policy

 A versioning policy is merely a set of simple rules governing how version
 numbers are allocated. It can be very simple (e.g. the version number is a
 single number starting with 1 and incremented for each successive version), or
 it can be really strange (Knuth's[#knuth] TeX project had version numbers: 3,
 3.1, 3.14, 3.141, 3.1415; each successive version added another digit to PI).

=== Why is this one ''Rational''?

 Because RubyGems provides support for version comparisons, we want to pick a
 policy that works well with the RubyGems comparisons and gives the end user
 what they expect. We call such a policy "rational". Also, if we call
 non-working policies "irrational", then we apply a little bit of social
 engineering to gently prod offenders to conform.

 By the way, Knuth's versioning policy (mentioned above) is not only irrational,
 it is also transcendental.

=== Ways Libraries Change

 Users expect to be able to specify a version constraint that gives them some
 reasonable expectation that new versions of a library will work with their
 software if the version constraint is true, and not work with their software if
 the version constraint is false. In other words, the perfect system will accept
 all compatible versions of the library and reject all incompatible versions.

 Libraries change in 3 ways (well, more than 3, but stay focused here!).

 # The change may be an implementation detail only and have no effect on the
 client software. # The change may add new features, but do so in a way that
 client software written to an earlier version is still compatible. # The change
 may change the public interface of the library in such a way that old software
 is no longer compatible.

 Some examples are appropriate at this point. Suppose I have a Stack class that
 supports a <tt>push</tt> and a <tt>pop</tt> method.

 Examples of Category 1 changes:

 * Switch from an array based implementation to a linked-list based
 implementation. * Provide an automatic (and transparent) backing store for
 large stacks.

 Examples of Category 2 changes might be:

 * Add a <tt>depth</tt> method to return the current depth of the stack. * Add a
 <tt>top</tt> method that returns the current top of stack (without changing the
 stack). * Change <tt>push</tt> so that it returns the item pushed (previously
 it had no usable return value).

 Examples of Category 3 changes might be:

 * Changes <tt>pop</tt> so that it no longer returns a value (you must use
 <tt>top</tt> to get the top of the stack). * Rename the methods to
 <tt>push_item</tt> and <tt>pop_item</tt>.

=== Ok, Give me the Details

 The RationalVersioningPolicy provides the following guidelines:

 * Versions shall be represented by three non-negative integers, separated by
 periods (e.g. 3.1.4). The first integers is the '''major''' version number, the
 second integer is the '''minor''' version number, and the third integer is the
 '''build''' number.

 * A category 1 change (implementation detail) will increment the build number.

 * A category 2 change (backwards compatible) will increment the minor version
 number and reset the build number.

 * A category 3 change (incompatible) will increment the major build number and
 reset the minor and build numbers.

 * Any ''public'' release of a gem should have a different version. Normally
 that means incrementing the build number. This means a developer can generate
 builds all day long for himself, but as soon as he/she makes a public release,
 the version must be updated.

 That's it. It's not <em>too</em> difficult.

=== Examples

 Let's work through a project lifecycle using our Stack example from above.

 * <b>Version 0.0.1</b>: The initial Stack class is release. * <b>Version
 0.0.2</b>: Switched to a linked=list implementation because it is cooler. *
 <b>Version 0.1.0</b>: Added a <tt>depth</tt> method. * <b>Version 1.0.0</b>:
 Added <tt>top</tt> and made <tt>pop</tt> return nil (<tt>pop</tt> used to
 return the old top item). * <b>Version 1.1.0</b>: <tt>push</tt> now returns the
 value pushed (it used it return nil). * <b>Version 1.1.1</b>: Fixed a bug in
 the linked list implementation. * <b>Version 1.1.2</b>: Fixed a bug introduced
 in the last fix.

 Client A needs a stack with basic push/pop capability. He writes to the
 original interface (no <tt>top</tt>), so his version constraint looks like ...

 <pre> gem 'stack', '>= 0.0' # However, in this case, it's sufficient just to
 skip the gem call, and require the library: require 'stack' </pre>

 Essentially, any version is OK with Client A. An incompatible change to the
 library will cause him grief, but he is willing to take the chance (we call
 Client A optimistic).

 Client B is just like Client A except for two things: (1) He uses the
 <tt>depth</tt> method and (2) he is worried about future incompatibilities, so
 he writes his version constraint like this:

 <pre> gem 'stack', '>=0.1', '< 1.0' require 'stack' </pre>

 The <tt>depth</tt> method was introduced in version 0.1.0, so that version or
 anything later is fine, as long as the version stay below version 1.0 where
 incompatibilities are introduced. We call Client B pessimistic because he is
 worried about incompatible future changes (it is OK to be pessimistic!).

 Client B <em>could</em> have written the his pessimistic constraint like this
 ...

 <pre> gem 'stack', '~> 0.1' require 'stack' </pre>

 This uses the pessimistic comparison operator and short hand for the previous
 version (see PessimisticVersionConstraint).

=== Summary

 Although RubyGems provides no mechanism to enforce versioning policy, we feel
 that this is an important issue. And it will become more important as the
 number of gems increases and the number of versions proliferate. So we strongly
 encourage developers to follow the RationalVersioningPolicy, or at least one of
 the VersioningPolicyVariations.

 There are several good ways to manage complex versioning manifests for gem
 dependencies, and these packages are available as gems:

 <pre> bundler # "Semantic Versioning" http://gembundler.com/ isolate # "KISS
 Versioning" http://github.com/jbarnette/isolate </pre>

== Creating Your Own Gem

=== Building a gem

 This is a skimpy overview; see the DeveloperGuide for the real meat.

 Let's say we have a package called ''mygem'' which is at version 2.1.

 Building a gem involves two steps: * creating a _gem specification file_
 (<tt>mygem.gemspec</tt>), which is Ruby code; and * running <tt>gem build
 mygem.gemspec</tt> to create the gem file (<tt>mygem-2.1.gem</tt>)

 The specification contains Ruby code to create a <tt>Gem::Specification</tt>
 object, which defines all of the information we saw above in <i>Looking at an
 installed gem</i>.

 The gem file contains everything needed to install itself on another computer,
 including the specification and all the file data.

 See? Building a gem is very easy!

 *Note:* "rake":http://rake.rubyforge.org (http://rake.rubyforge.org) is a big
 help in creating gem files in a project setting, where the version number is
 always changing, etc.

== Distributing Gems

=== Distributing with rubygems.org

 Building and distributing gems with rubygems.org is easy. As of RubyGems 1.3.6,
 rubygems.org is now fully integrated into the main rubygems suite, and gems can
 be built and published with ease:

 <pre> gem build foo.gemspec gem push foo-1.0.0.gem </pre>

 The <code>gem push</code> command will instantly deploy your gem to the
 rubygems.org servers, and other users will be able to install it using
 <code>gem install</code>.

=== Homebrew  Distribution

 Make your gem available on a web site for FTP site for downloading. Users can
 get the gem with conventional internet tools (e.g. browsers and FTP clients)
 and do a local install.

=== Remote Serving

 By running @gem server@ on your box, you can serve your entire set of installed
 gems to anyone.

 The documentation for @gem server@ is available through the built in help
 system, and the following commands provide further useful information for gem
 server and gem index hosting:

 <pre> gem help server gem help generate_index </pre>

 By default the @gem server@ will start a server on
 "localhost:8808":http://localhost:8808/

 Users can install gems from this server using the @--source@ option to @gem
 install@, for example:

 <pre> gem install --source http://mygemserver:8808/ rake </pre>

=== Distributing on RubyForge (the old way)

 "RubyForge":http://rubyforge.org (http://rubyforge.org) will automatically
 deploy any .gem file you upload to a project download area to rubygems.org.

== Signing Your Gems

=== Overview

 p(((. <em>This chapter is provided by Paul Duncan, the author of the signing
 patch.</em>

 RubyGems version 0.8.11 and later supports adding cryptographic signatures to
 gems. The section below is a step-by-step guide to using signed gems and
 generating your own.

=== Walkthrough

 In order to start signing your gems, you'll need to build a private key and a
 self-signed certificate. Here's how:

 <pre> # build a private key and certificate for gemmaster@example.com $ gem
 cert --build gemmaster@example.com </pre>

 This could take anywhere from 5 seconds to 10 minutes, depending on the speed
 of your computer (public key algorithms aren't exactly the speediest crypto
 algorithms in the world). When it's finished, you'll see the files
 "gem-private_key.pem" and "gem-public_cert.pem" in the current directory.

 First things first: take the "gem-private_key.pem" file and move it somewhere
 private, preferably a directory only you have access to, a floppy (yuck!), a
 CD-ROM, or something comparably secure. Keep your private key hidden; if it's
 compromised, someone can sign packages as you (note: PKI has ways of mitigating
 the risk of stolen keys; more on that later).

 Now, let's sign an existing gem. I'll be using my Imlib2-Ruby bindings, but you
 can use whatever gem you'd like. Open up your existing gemspec file and add the
 following lines:

 <pre> # signing key and certificate chain s.signing_key =
 '/mnt/floppy/gem-private_key.pem' s.cert_chain = ['gem-public_cert.pem'] </pre>

 (Be sure to replace "/mnt/floppy" with the ultra-secret path to your private
 key).

 After that, go ahead and build your gem as usual. Congratulations, you've just
 built your first signed gem! If you peek inside your gem file, you'll see a
 couple of new files have been added:

 <pre> $ tar tf tar tf Imlib2-Ruby-0.5.0.gem data.tar.gz data.tar.gz.sig
 metadata.gz metadata.gz.sig </pre>

 Now let's verify the signature. Go ahead and install the gem, but add the
 following options: "-P HighSecurity", like this:

 <pre> # install the gem with using the security policy "HighSecurity" $ sudo
 gem install Imlib2-Ruby-0.5.0.gem -P HighSecurity </pre>

 The -P option sets your security policy -- we'll talk about that in just a
 minute. Eh, what's this?

 <pre> Attempting local installation of 'Imlib2-Ruby-0.5.0.gem' ERROR: Error
 installing gem Imlib2-Ruby-0.5.0.gem[.gem]: Couldn't verify data signature:
 Untrusted Signing Chain Root: cert = '/CN=gemmaster/DC=example/DC=com', error =
 'path "/root/.rubygems/trust/cert-15dbb43a6edf6a70a85d4e784e2e45312cff7030.pem"
 does not exist' </pre>

 The culprit here is the security policy. RubyGems has several different
 security policies. Let's take a short break and go over the security policies.
 Here's a list of the available security policies, and a brief description of
 each one: * NoSecurity - Well, no security at all. Signed packages are treated
 like unsigned packages. * LowSecurity - Pretty much no security. If a package
 is signed then RubyGems will make sure the signature matches the signing
 certificate, and that the signing certificate hasn't expired, but that's it. A
 malicious user could easily circumvent this kind of security. * MediumSecurity
 - Better than LowSecurity and NoSecurity, but still fallible. Package contents
 are verified against the signing certificate, and the signing certificate is
 checked for validity, and checked against the rest of the certificate chain (if
 you don't know what a certificate chain is, stay tuned, we'll get to that). The
 biggest improvement over LowSecurity is that MediumSecurity won't install
 packages that are signed by untrusted sources. Unfortunately, MediumSecurity
 still isn't totally secure -- a malicious user can still unpack the gem, strip
 the signatures, and distribute the gem unsigned. * HighSecurity - Here's the
 bugger that got us into this mess. The HighSecurity policy is identical to the
 MediumSecurity policy, except that it does not allow unsigned gems. A malicious
 user doesn't have a whole lot of options here; he can't modify the package
 contents without invalidating the signature, and he can't modify or remove
 signature or the signing certificate chain, or RubyGems will simply refuse to
 install the package. Oh well, maybe he'll have better luck causing problems for
 CPAN users instead :). So, the reason RubyGems refused to install our shiny new
 signed gem was because it was from an untrusted source. Well, my code is
 infallible (hah!), so I'm going to add myself as a trusted source. Here's how:

 <pre> # add trusted certificate gem cert --add gem-public_cert.pem </pre> I've
 added my public certificate as a trusted source. Now I can install packages
 signed my private key without any hassle. Let's try the install command above
 again:

 <pre> # install the gem with using the HighSecurity policy (and this time #
 without any shenanigans) $ sudo gem install Imlib2-Ruby-0.5.0.gem -P
 HighSecurity </pre>

 This time RubyGems should accept your signed package and begin installing.
 While you're waiting for RubyGems to work it's magic, have a look at some of
 the other security commands:

 <pre> Usage: gem cert [options]

 Options: -a, --add CERT Add a trusted certificate. -l, --list List trusted
 certificates. -r, --remove STRING Remove trusted certificates containing
 STRING. -b, --build EMAIL_ADDR Build private key and self-signed certificate
 for EMAIL_ADDR. -C, --certificate CERT Certificate for --sign command. -K,
 --private-key KEY Private key for --sign command. -s, --sign NEWCERT Sign a
 certificate with my key and certificate. </pre>

 (By the way, you can pull up this list any time you'd like by typing "gem cert
 --help")

 Hmm. We've already covered the "--build" option, and the "--add", "--list", and
 "--remove" commands seem fairly straightforward; they allow you to add, list,
 and remove the certificates in your trusted certificate list. But what's with
 this "--sign" option?

 To answer that question, let's take a look at "certificate chains", a concept I
 mentioned earlier. There are a couple of problem s with self-signed
 certificates: first of all, self-signed certificates don't offer a whole lot of
 security. Sure, the certificate says Yukihiro Matsumoto, but how do I know it
 was actually generated and signed by Matz himself unless he gave me the
 certificate in person?

 The second problem is scalability. Sure, if there are 50 gem authors, then I
 have 50 trusted certificates, no problem. What if there are 500 gem authors?
 1000? Having to constantly add new trusted certificates is a pain, and it
 actually makes the trust system less secure by encouraging RubyGems users to
 blindly trust new certificates.

 Here's where certificate chains come in. A certificate chain establishes an
 arbitrarily long chain of trust between an issuing certificate and a child
 certificate. So instead of trusting certificates on a per-developer basis, we
 use the PKI concept of certificate chains to build a logical hierarchy of
 trust. Here's a hypothetical example of a trust hierarchy based (roughly) on
 geography:

 <pre> -------------------------- | rubygems@rubyforge.org |
 -------------------------- | ----------------------------------- | |
 ---------------------------- ----------------------------- |
 seattle.rb@zenspider.com | | dcrubyists@richkilmer.com |
 ---------------------------- ----------------------------- | | | |
 --------------- ---------------- ----------- -------------- | alf@seattle | |
 bob@portland | | pabs@dc | | tomcope@dc | --------------- ----------------
 ----------- -------------- </pre>

 Now, rather than having 4 trusted certificates (one for alf@seattle,
 bob@portland, pabs@dc, and tomecope@dc), a user could actually get by with 1
 certificate: the "rubygems@rubyforge.org" certificate. Here's how it works:

 I install "Alf2000-Ruby-0.1.0.gem", a package signed by "alf@seattle". I've
 never heard of "alf@seattle", but his certificate has a valid signature from
 the "seattle.rb@zenspider.com" certificate, which in turn has a valid signature
 from the "rubygems@rubyforge.org" certificate. Voila! At this point, it's much
 more reasonable for me to trust a package signed by "alf@seattle", because I
 can establish a chain to "rubygems@rubyforge.org", which I do trust.

 And the "--sign" option allows all this to happen. A developer creates their
 build certificate with the "--build" option, then has their certificate signed
 by taking it with them to their next regional Ruby meetup (in our hypothetical
 example), and it's signed there by the person holding the regional RubyGems
 signing certificate, which is signed at the next RubyConf by the holder of the
 top-level RubyGems certificate. At each point the issuer runs the same command:

 <pre> # sign a certificate with the specified key and certificate # (note that
 this modifies client_cert.pem!) $ gem cert -K /mnt/floppy/issuer-priv_key.pem
 -C issuer-pub_cert.pem \ --sign client_cert.pem </pre>

 Then the holder of issued certificate (in this case, our buddy "alf@seattle"),
 can start using this signed certificate to sign RubyGems. By the way, in order
 to let everyone else know about his new fancy signed certificate, "alf@seattle"
 would change his gemspec file to look like this:

 <pre> # signing key (still kept in an undisclosed location!) s.signing_key =
 '/mnt/floppy/alf-private_key.pem' # certificate chain (includes the issuer
 certificate now too) s.cert_chain = ['/home/alf/doc/seattlerb-public_cert.pem',
 '/home/alf/doc/alf_at_seattle-public_cert.pem'] </pre>

 Obviously, this RubyGems trust infrastructure doesn't exist yet (I just wrote
 the patch, for cripes sake!). Also, in the "real world" issuers actually
 generate the child certificate from a certificate request, rather than sign an
 existing certificate. And our hypothetical infrastructure is missing a
 certificate revocation system. These are that can be fixed in the future... I'm
 sure your new signed gem has finished installing by now (unless you're
 installing rails and all it's dependencies, that is ;D). At this point you
 should know how to do all of these new and interesting things:

 * build a gem signing key and certificate * modify your existing gems to
 support signing * adjust your security policy * modify your trusted certificate
 list * sign a certificate

 If you've got any questions, feel free to contact me at the email address
 below.

=== Command-Line Options

 Here's a brief summary of the certificate-related command line options:

 <pre> gem install -P, --trust-policy POLICY Specify gem trust policy.

 gem cert -a, --add CERT Add a trusted certificate. -l, --list List trusted
 certificates. -r, --remove STRING Remove trusted certificates containing
 STRING. -b, --build EMAIL_ADDR Build private key and self-signed certificate
 for EMAIL_ADDR. -C, --certificate CERT Certificate for --sign command. -K,
 --private-key KEY Private key for --sign command. -s, --sign NEWCERT Sign a
 certificate with my key and certificate. <pre>

 A more detailed description of each options is available in the walkthrough
 above.

=== OpenSSL Reference

 The .pem files generated by --build and --sign are just basic OpenSSL PEM
 files. Here's a couple of useful commands for manipulating them:

 <pre> # convert a PEM format X509 certificate into DER format: # (note: Windows
 .cer files are X509 certificates in DER format) $ openssl x509 -in input.pem
 -outform der -out output.der

 # print out the certificate in a human-readable format: $ openssl x509 -in
 input.pem -noout -text </pre>

 And you can do the same thing with the private key file as well:

 <pre> # convert a PEM format RSA key into DER format: $ openssl rsa -in
 input_key.pem -outform der -out output_key.der

 # print out the key in a human readable format: $ openssl rsa -in input_key.pem
 -noout -text </pre>

=== Bugs/TODO

 * right now I'm using Gem.user_home + '.gem/trust' for the trusted cert list.
 There's no way to define a system-wide trust list. * custom security policies
 (from a YAML file, etc) * Simple method to generate a signed certificate
 request * Support for OCSP, SCVP, CRLs, or some other form of cert status check
 (list is in order of preference) * Support for encrypted private keys * Some
 sort of semi-formal trust hierarchy (see long-winded explanation above) * Path
 discovery (for gem certificate chains that don't have a self-signed root) -- by
 the way, since we don't have this, THE ROOT OF THE CERTIFICATE CHAIN MUST BE
 SELF SIGNED if Policy#verify_root is true (and it is for the MediumSecurity and
 HighSecurity policies) * Better explanation of X509 naming (ie, we don't have
 to use email addresses) * possible alternate signing mechanisms (eg, via PGP).
 This could be done pretty easily by adding a :signing_type attribute to the
 gemspec, then add the necessary support in other places * honor AIA field (see
 note about OCSP above) * maybe honor restriction extensions? * might be better
 to store the certificate chain as a PKCS#7 or PKCS#12 file, instead of an array
 embedded in the metadata. ideas? * possibly embed signature and key algorithms
 into metadata (right now they're assumed to be the same as what's set
 inGem::Security::OPT)

=== About the Author

 Paul Duncan (pabs@pablotron.org)

 http://pablotron.org/

