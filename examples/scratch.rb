require 'rubygems'
require 'bundler'
Bundler.require
require 'fmod'

start_time = Time.now
puts "initializing FMOD ..."
FMOD.init
end_time = Time.new - start_time
puts "done in #{end_time} seconds."

DIR = File.dirname(__FILE__)

file = (ARGV.empty?) ? "#{DIR}/ComputerMagic.mp3" : ARGV[0]


puts "initializing a sound ..."
start_time = Time.now
sound = FMOD::Sound.new(file)
end_time = Time.new - start_time
puts "done in #{end_time} seconds."
sound.play
puts FMOD.system.version
puts sound.channel.frequency
puts "sound length=#{sound.length}ms"
sleep 2
# sound.channel.frequency = 11050.0
# puts sound.channel.frequency
# 10.times do |i|
#   sound.channel.set_position(i + 1000)
#   sleep 0.1
# end

# sleep 2

1000.times do |i|
  sound.channel.set_position(i * (rand*1000).to_i)
  sleep rand
end
# 
# sr   = 100  
# step = 1.0/sr
# time = 0.0
# 
# loop do
#   time += step
#   val = Math.cos(time * 2 * Math::PI * 440.0) * Math.cos(time * 2 * Math::PI)
#   sound.channel.frequency = val * 20000
#   sleep step
# end

# block
while true
  sleep 5
end
