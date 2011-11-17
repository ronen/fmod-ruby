module FMOD
  class Sound
    include Functions
    attr_reader :channel
    
    def initialize(file, options = {})
      @system_pointer  = FMOD.system.pointer
      @channel = options[:channel] || Channel.new
      @file = file
      @sound_ptr = nil
    end

    def length(unit = FMOD_TIMEUNIT_MS)
      FFI::MemoryPointer.new(:int) do |ptr|
        error_check FMOD_Sound_GetLength(sound_ptr.read_pointer, ptr, FMOD_TIMEUNIT_MS)
        return ptr.read_int
      end
    end
    
    def play
      play_stream
    end

    def play_sound
      # FMOD_RESULT = FMOD_System_CreateStream(system, "wave.mp3", FMOD_DEFAULT, 0, &sound);
      error_check FMOD_System_CreateStream(@system_pointer.read_pointer, @file, FMOD_DEFAULT, 0, sound_ptr);

      # FMOD_RESULT = FMOD_System_PlaySound(system, FMOD_CHANNEL_FREE, sound1, 0, &channel);
      error_check FMOD_System_PlaySound(@system_pointer.read_pointer, FMOD_CHANNELINDEX[:FMOD_CHANNEL_FREE], sound_ptr.read_pointer, 0, @channel.pointer);
      true
    end
    
    def play_stream  
      # FMOD_RESULT = FMOD_System_CreateSound(system, "drumloop.wav", FMOD_SOFTWARE, 0, &sound);
      error_check FMOD_System_CreateSound(@system_pointer.read_pointer, @file, FMOD_DEFAULT, 0, sound_ptr);

      # FMOD_RESULT = FMOD_System_PlaySound(system, FMOD_CHANNEL_FREE, sound1, 0, &channel);
      error_check FMOD_System_PlaySound(@system_pointer.read_pointer, FMOD_CHANNELINDEX[:FMOD_CHANNEL_FREE], sound_ptr.read_pointer, 0, @channel.pointer);
      true
    end

    private

    def sound_ptr
      @sound_ptr ||= FFI::MemoryPointer.new(:pointer)
    end

    
  end 
end
