module FMOD
  class Channel
    include Functions
    # pointer to the channel instance
    attr_reader :pointer
    
    # TODO: Need to find a way to reliably destroy this pointer
    def initialize(options = {})
      @memory = FFI::MemoryPointer.new(:pointer)
    end

    def pointer
      @memory.read_pointer
    end

    def pointer_addr
      @memory
    end

    
    # result = FMOD_Channel_IsPlaying(channel, &playing);
    def playing?
      FFI::MemoryPointer.new(:int) do |ptr|
        error_check FMOD_Channel_IsPlaying(pointer, ptr)
        return ptr.read_int == 1
      end
    end
    
    def pause
      error_check FMOD_Channel_SetPaused(pointer, ((paused?) ? 0 : 1))
    end

    def set_paused(bool)
      error_check FMOD_Channel_SetPaused(pointer, (bool ? 1 : 0))
    end
    
    def paused?
      FFI::MemoryPointer.new(:int) do |ptr|
        error_check FMOD_Channel_GetPaused(pointer, ptr)
        return ptr.read_int == 1
      end
    end
    
    def set_position(int = 0)
      error_check FMOD_Channel_SetPosition(pointer, int, FMOD_TIMEUNIT_MS)
    end
    
    def pan=(float)
      float = 1.0 if float > 1.0
      float = 0.0 if float < 0.0
      error_check FMOD_Channel_SetPan(pointer, float)
    end
    
    def frequency
      FFI::MemoryPointer.new(:float) do |ptr|
        error_check FMOD_Channel_GetFrequency(pointer, ptr)
        return ptr.read_float
      end
    end
    
    def frequency=(float)
      error_check FMOD_Channel_SetFrequency(pointer, float)
    end

    def set_delay(samples, opts={})
      opts = opts.keyword_args(:delaytype => :required)
      hi, lo = Convert.int64_to_32(samples)
      error_check FMOD_Channel_SetDelay(pointer, opts.delaytype, hi, lo)
    end

    def get_delay(opts={})
      opts = opts.keyword_args(:delaytype => :required)

      FFI::MemoryPointer.new(:int) { |hi|
        FFI::MemoryPointer.new(:int) { |lo|
          error_check FMOD_Channel_GetDelay(pointer, opts.delaytype, hi, lo)
          return Convert.int32_to_64(hi.read_int, lo.read_int)
        }
      }
    end
  end
end
