#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require
require 'fmod'
DIR = File.dirname(__FILE__)

puts "calling FMOD.init..."
FMOD.init

file = (ARGV.empty?) ? "#{DIR}/Flute3.wav" : ARGV[0]

puts "creating sound #{file}..."
sound = FMOD::Sound.new(file)
puts "#{file} length=#{sound.length}ms"
puts "playing at full volume:"
sound.play
sleep (sound.length/1000.0).ceil

puts "playing at quarter volume:"
sound.play(:paused => true)
sound.channel.set_volume(0.25)
sound.channel.set_paused(false)
sleep (sound.length/1000.0).ceil
