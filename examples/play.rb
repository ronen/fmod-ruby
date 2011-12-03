#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'
Bundler.require
require 'fmod'
DIR = File.dirname(__FILE__)

puts "calling FMOD.init..."
FMOD.init

file = (ARGV.empty?) ? "#{DIR}/ComputerMagic.mp3" : ARGV[0]

puts "creating sound #{file}..."
sound = FMOD::Sound.new(file)
puts "#{file} length=#{sound.length}ms"
sound.play
puts "scheduled play.  now starting to sleep"
sleep(sound.length/1000.0)
