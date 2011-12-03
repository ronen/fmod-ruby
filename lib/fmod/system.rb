module FMOD
  class System
    include Functions
    # pointer to the system instance
    attr_reader :pointer
    attr_reader :sample_rate
        
    def initialize(opts={})

      @sample_rate = opts[:sample_rate] || 44100

      @memory = FFI::MemoryPointer.new(:pointer)
      error_check FMOD_System_Create(@memory)  
      @pointer = @memory.read_pointer

      case
      when opts[:output_wav]
        error_check FMOD_System_SetOutput(@pointer, :FMOD_OUTPUTTYPE_WAVWRITER_NRT)
        error_check FMOD_System_SetSoftwareFormat(@pointer, sample_rate, :FMOD_SOUND_FORMAT_PCM16, 2, 6, :FMOD_DSP_RESAMPLER_LINEAR)
        error_check FMOD_System_Init(@pointer, 100,  FMOD_INIT_STREAM_FROM_UPDATE, opts[:output_wav])
      else
        error_check FMOD_System_Init(@pointer, 32, FMOD_INIT_NORMAL, nil)
      end
    end
    
    def version
      # unsigned int version;
      # result = FMOD_System_GetVersion(system, &version);
      FFI::MemoryPointer.new(:int) { |version_ptr|
        error_check FMOD_System_GetVersion(@pointer, version_ptr);
        return version_ptr.read_int
      }
    end
    
    def driver_count
      # unsigned int numdrivers;
      # result = FMOD_System_GetNumDrivers(system, &numdrivers);
      FFI::MemoryPointer.new(:int) { |count_ptr|
        error_check FMOD_System_GetNumDrivers(@pointer, count_ptr)
        count_ptr.read_int
      }
    end
    
    def software_channels
      FFI::MemoryPointer.new(:int) { |num_ptr|
        error_check FMOD_System_GetSoftwareChannels(@pointer, num_ptr)
        num_ptr.read_int
      }
    end
    
    def hardware_channels
      FFI::MemoryPointer.new(:int) { |num2d|
        FFI::MemoryPointer.new(:int) { |num3d|
          FFI::MemoryPointer.new(:int) { |total|
            error_check FMOD_System_GetHardwareChannels(@pointer, num2d, num3d, total)

            {
              :num2d => num2d.read_int,
              :num3d => num3d.read_int,
              :total => total.read_int,
            }
          }
        }
      }
    end

    def dsp_clock
      FFI::MemoryPointer.new(:int) { |hi|
        FFI::MemoryPointer.new(:int) { |lo|
          error_check FMOD_System_GetDSPClock(@pointer, hi, lo)
          return Convert.int32_to_64(hi.read_int, lo.read_int)
        }
      }
    end


    def update
      error_check FMOD_System_Update(@pointer)
    end

    def release
      error_check FMOD_System_Release(@pointer)
    end
  end
end
