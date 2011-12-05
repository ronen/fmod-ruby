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
        error_check FMOD_Sound_GetLength(sound_ptr, ptr, FMOD_TIMEUNIT_MS)
        return ptr.read_int
      end
    end
    
    def play(opts={})
      opts = opts.keyword_args(:paused)
      # FMOD_RESULT = FMOD_System_PlaySound(system, FMOD_CHANNEL_FREE, sound1, 0, &channel);
      error_check FMOD_System_PlaySound(FMOD.system.pointer, :FMOD_CHANNEL_FREE, sound_ptr, opts.paused ? 1 : 0, @channel.pointer_addr);
      true
    end

    def release
      return unless @sound_ptr
      error_check FMOD_Sound_Release(@sound_ptr)
      @sound_ptr = nil
    end

    private

    def sound_ptr
      return @sound_ptr if @sound_ptr

      @memory = FFI::MemoryPointer.new(:pointer)
      # FMOD_RESULT = FMOD_System_CreateSound(system, "drumloop.wav", FMOD_SOFTWARE, 0, &sound);
      error_check FMOD_System_CreateSound(@system_pointer, @file, FMOD_DEFAULT, 0, @memory);

      @sound_ptr = @memory.read_pointer
    end

    
  end 
end
