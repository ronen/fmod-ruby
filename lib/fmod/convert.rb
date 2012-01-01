module FMOD
  module Convert

    # since ruby will automatically convert to a Bignum if needed, this
    # should work fine even on 32-bit platforms
    def self.int32_to_64(hi32, lo32)
      (hi32 << 32) | lo32
    end

    def self.int64_to_32(int64)
      [(int64 & 0xFFFFFFFF00000000) >> 32, int64 & 0xFFFFFFFF]
    end

    def self.ms_to_samples(ms, opts={})
      opts = opts.keyword_args(:sample_rate => FMOD.system.sample_rate) # samples per second
      ms * opts.sample_rate / 1000
    end

    def self.samples_to_ms(samples, opts={})
      opts = opts.keyword_args(:sample_rate => FMOD.system.sample_rate) # samples per second
      (samples / opts.sample_rate) * 1000
    end
  end
end
