require 'ffi'
require 'hash_keyword_args'

require 'fmod/version'

require 'fmod/constants'
require 'fmod/enums'
require 'fmod/functions'
         
require 'fmod/convert'
require 'fmod/channel'
require 'fmod/sound'
require 'fmod/system'

module FMOD
  def self.init(*args)
    @system = System.new(*args)
  end
  
  # Ruby version of the system
  def self.system
    @system
  end
  
  # This pointer is used by many of the sound functions
  def self.system_pointer
    @system.pointer
  end

  class Error < ::RuntimeError
  end
end
