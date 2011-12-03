#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require
require 'fmod'

DIR = File.dirname(__FILE__)
PROG = File.basename(__FILE__, '.*')


infile = (ARGV.empty?) ? "#{DIR}/ComputerMagic.mp3" : ARGV[0]
outfile = "#{DIR}/output/#{PROG}.wav"
puts "writing to #{outfile}"

puts "calling FMOD.init"
FMOD.init(:output_wav => outfile)

puts "creating sound #{infile}"
sound = FMOD::Sound.new(infile)
puts "#{infile} length=#{sound.length}ms"

puts "scheduling play..."
sound.play

samples = FMOD::Convert.ms_to_samples(sound.length)
puts "updating until #{samples} samples"

while (dsp_clock = FMOD.system.dsp_clock) < samples
  pct = (100.0*dsp_clock/samples).round
  puts "  dsp_clock = #{dsp_clock} (#{pct}% of #{samples})" if pct % 10 == 0
  FMOD.system.update
end

puts "done.  releasing."
FMOD.system.release
