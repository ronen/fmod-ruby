#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require
require 'fmod'

DIR = File.dirname(__FILE__)
PROG = File.basename(__FILE__, '.*')


infile1 = (ARGV.empty?) ? "#{DIR}/ComputerMagic.mp3" : ARGV.shift
infile2 = (ARGV.empty?) ? "#{DIR}/Flute3.wav" : ARGV.shift

puts "calling FMOD.init"
FMOD.init

sound1 = FMOD::Sound.new(infile1)
puts "#{infile1} length=#{sound1.length}ms"
sound2 = FMOD::Sound.new(infile2)
puts "#{infile2} length=#{sound2.length}ms"

puts "scheduling play..."
sound1.play
sound2.play
puts "scheduled play.  now starting to sleep"
sleep ([sound1.length,sound2.length].max/1000.0).ceil
