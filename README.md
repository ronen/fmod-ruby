FMOD for Ruby
-------------

*ruby-fmod* wraps the excellent [FMOD](http://www.fmod.org) C/C++ libraries using the equally excellent [FFI](http://github.com/ffi/ffi).

It is far from complete, but all the basic techniques for interfacing Ruby with the FMOD library are outlined. The authors have (so far) fleshed out only the parts needed for their own projects.  Please do fork this project and contribute to it.

FMOD?
=====

"FMOD is a programming library and toolkit for the creation and playback of interactive audio. It supports all leading operating systems and game platforms." And now Ruby too. FMOD supports all sorts of audio file playback, surround sound and multichannel, as well as effects, VST plugins, 3D sound, and wavetable synthesis.

FMOD is not free, nor is it open source, but it does have a very [liberal license](http://www.fmod.org/index.php/sales). While commercial use is quite expensive, it is free to use in your non-commercial projects.

Installation
============

To use this Ruby library, you must have the FMOD on you machine. [Go get it](http://www.fmod.org/index.php/download). 

That being said:

  gem install fmod-ruby

or, in a Gemfile

  gem "fmod-ruby", :require => "fmod"

Testing
=======

No formal test suite yet.  However, the +examples/+ directory includes several examples that should all work.

History
=======

* release 0.3.1 - cleaned up exception message
* release 0.3.0 - added FMOD::Error, more detailed error reporting in exception message
* release 0.2.0 - added Convert.samples_to_ms
* release 0.1.1 - added Channel#set_volume, Sound#release
* release 0.1.0 - added keyword options to System#initialize and whatnot to support offline wav creation (examples write.rb and contact.rb)

* release 0.0.1 - initial gemification
  
Usage
=====

  require "fmod"

  FMOD.init
  sound = FMOD::Sound.new(file)
  sound.play

See +examples/*+ for more examples

