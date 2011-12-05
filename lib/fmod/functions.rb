module FMOD
  module Functions
    extend  FFI::Library
    include Constants
    include Enums
    
    ffi_lib 'libfmodex'
    
    typedef :int,  :FMOD_BOOL                       
    typedef :uint, :FMOD_TIMEUNIT
    typedef :uint, :FMOD_MODE
    typedef :uint, :FMOD_INITFLAGS
    typedef :uint, :FMOD_CAPS
    typedef :uint, :FMOD_DEBUGLEVEL
    typedef :uint, :FMOD_MEMORY_TYPE
    
    # typedef struct FMOD_SYSTEM        FMOD_SYSTEM;
    # typedef struct FMOD_SOUND         FMOD_SOUND;
    # typedef struct FMOD_CHANNEL       FMOD_CHANNEL;
    # typedef struct FMOD_CHANNELGROUP  FMOD_CHANNELGROUP;
    # typedef struct FMOD_SOUNDGROUP    FMOD_SOUNDGROUP;
    # typedef struct FMOD_REVERB        FMOD_REVERB;
    # typedef struct FMOD_DSP           FMOD_DSP;
    # typedef struct FMOD_DSPCONNECTION FMOD_DSPCONNECTION;
    # typedef struct FMOD_POLYGON     FMOD_POLYGON;
    # typedef struct FMOD_GEOMETRY    FMOD_GEOMETRY;
    # typedef struct FMOD_SYNCPOINT   FMOD_SYNCPOINT;


    # SYSTEM FUNCTIONS
    attach_function :FMOD_System_Create, [:pointer], FMOD_RESULT
    attach_function :FMOD_System_GetVersion, [:pointer, :pointer], FMOD_RESULT
    attach_function :FMOD_System_Init, [:pointer, :int, :int, :pointer], FMOD_RESULT
    attach_function :FMOD_System_Update, [:pointer], FMOD_RESULT
    attach_function :FMOD_System_Release, [:pointer], FMOD_RESULT
    attach_function :FMOD_System_GetDSPClock, [:pointer, :pointer, :pointer], FMOD_RESULT
    attach_function :FMOD_System_GetDSPBufferSize, [:pointer, :pointer, :pointer], FMOD_RESULT
    attach_function :FMOD_System_SetSoftwareFormat, [:pointer, :int, FMOD_SOUND_FORMAT, :int, :int, FMOD_DSP_RESAMPLER], FMOD_RESULT
  
    attach_function :FMOD_System_CreateSound, [:pointer, :string, :int, :int, :pointer], FMOD_RESULT
    attach_function :FMOD_System_CreateStream, [:pointer, :string, :int, :int, :pointer], FMOD_RESULT
    attach_function :FMOD_System_PlaySound, [:pointer, FMOD_CHANNELINDEX, :pointer, :int, :pointer], FMOD_RESULT
  
    # FMOD_RESULT FMOD_System_GetDriverInfo(FMOD_SYSTEM * system, int id, char * name, int namelen, FMOD_GUID * guid);
    # attach_function :FMOD_System_GetDriverInfo

    # FMOD_RESULT FMOD_System_GetNumDrivers(FMOD_SYSTEM * system, int * numdrivers);
    attach_function :FMOD_System_GetNumDrivers, [:pointer, :pointer], FMOD_RESULT

    # FMOD_RESULT FMOD_System_GetHardwareChannels(FMOD_SYSTEM * system, int * num2d, int * num3d, int * total);
    attach_function :FMOD_System_GetHardwareChannels, [:pointer, :pointer, :pointer, :pointer], FMOD_RESULT

    # FMOD_RESULT FMOD_System_GetSoftwareChannels(FMOD_SYSTEM * system, int * numsoftwarechannels);
    attach_function :FMOD_System_GetSoftwareChannels, [:pointer, :pointer], FMOD_RESULT

    # FMOD_RESULT F_API FMOD_System_SetOutput              (FMOD_SYSTEM *system, FMOD_OUTPUTTYPE output);
    attach_function :FMOD_System_SetOutput, [:pointer, FMOD_OUTPUTTYPE], FMOD_RESULT
    
    # FMOD_RESULT F_API FMOD_System_GetOutput              (FMOD_SYSTEM *system, FMOD_OUTPUTTYPE *output);
    attach_function :FMOD_System_GetOutput, [:pointer, :pointer], FMOD_RESULT


    # FMOD_RESULT FMOD_Channel_IsPlaying(FMOD_CHANNEL *  channel, FMOD_BOOL *  isplaying);
    attach_function :FMOD_Channel_IsPlaying, [:pointer, :pointer], FMOD_RESULT
    
    # FMOD_RESULT FMOD_Channel_SetPaused(FMOD_CHANNEL * channel, FMOD_BOOL paused);
    attach_function :FMOD_Channel_SetPaused, [:pointer, :int], FMOD_RESULT
    
    # FMOD_RESULT FMOD_Channel_GetPaused(FMOD_CHANNEL * channel, FMOD_BOOL * paused);
    attach_function :FMOD_Channel_GetPaused, [:pointer, :pointer], FMOD_RESULT

    # FMOD_RESULT FMOD_Channel_SetPosition(FMOD_CHANNEL *  channel, unsigned int position, FMOD_TIMEUNIT postype);
    attach_function :FMOD_Channel_SetPosition, [:pointer, :int, :FMOD_TIMEUNIT], FMOD_RESULT
    
    # FMOD_RESULT FMOD_Channel_SetPan(FMOD_CHANNEL * channel, float pan);  
    attach_function :FMOD_Channel_SetPan, [:pointer, :float], FMOD_RESULT  
    
    # FMOD_RESULT FMOD_Channel_GetFrequency(FMOD_CHANNEL * channel, float * frequency);    
    attach_function :FMOD_Channel_GetFrequency, [:pointer, :pointer], FMOD_RESULT  

    # FMOD_RESULT FMOD_Channel_SetFrequency(FMOD_CHANNEL *  channel, float  frequency);    
    attach_function :FMOD_Channel_SetFrequency, [:pointer, :float], FMOD_RESULT  

    # FMOD_RESULT FMOD_Channel_SetDelay(FMOD_CHANNEL *channel, FMOD_DELAYTYPE delaytype, unsigned int delayhi, unsigned int delaylo);
    attach_function :FMOD_Channel_SetDelay, [:pointer, FMOD_DELAYTYPE, :int, :int], FMOD_RESULT

    # FMOD_RESULT FMOD_Channel_GetDelay(FMOD_CHANNEL *channel, FMOD_DELAYTYPE delaytype, unsigned int *delayhi, unsigned int *delaylo);
    attach_function :FMOD_Channel_GetDelay, [:pointer, FMOD_DELAYTYPE, :pointer, :pointer], FMOD_RESULT

    attach_function :FMOD_Channel_SetVolume, [:pointer, :float], FMOD_RESULT


    # FMOD_RESULT F_API FMOD_Sound_GetLength               (FMOD_SOUND *sound, unsigned int *length, FMOD_TIMEUNIT lengthtype);
    attach_function :FMOD_Sound_GetLength, [:pointer, :pointer, :FMOD_TIMEUNIT], FMOD_RESULT  

    
    def error_check(result)
      raise "FMOD error! #{result}" if result != :FMOD_OK
    end
  end
end
