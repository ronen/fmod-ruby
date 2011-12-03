#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require
require 'fmod'

DIR = File.dirname(__FILE__)
PROG = File.basename(__FILE__, '.*')


infile1 = (ARGV.empty?) ? "#{DIR}/ComputerMagic.mp3" : ARGV.shift
infile2 = (ARGV.empty?) ? "#{DIR}/Flute3.wav" : ARGV.shift
outfile = "#{DIR}/output/#{PROG}.wav"
puts "writing to #{outfile}"

puts "calling FMOD.init"
FMOD.init(:output_wav => outfile)

sound1 = FMOD::Sound.new(infile1)
puts "#{infile1} length=#{sound1.length}ms"
sound2 = FMOD::Sound.new(infile2)
puts "#{infile2} length=#{sound2.length}ms"

puts "scheduleing play..."
sound1.play
sound2.play(:paused => true)
sound2.channel.set_delay(FMOD::Convert.ms_to_samples(sound1.length), :delaytype => :FMOD_DELAYTYPE_DSPCLOCK_START)
sound2.channel.set_paused(false)

samples = FMOD::Convert.ms_to_samples(sound1.length + sound2.length)
puts "updating to #{samples} samples"

while (dsp_clock = FMOD.system.dsp_clock) < samples
  pct = (100.0*dsp_clock/samples).round
  puts "  dsp_clock = #{dsp_clock} (#{pct}% of #{samples})" if pct % 10 == 0
  FMOD.system.update
end

puts "done.  releasing."
FMOD.system.release
