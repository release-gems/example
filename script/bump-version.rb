#!/usr/bin/ruby
require 'open3'

Dir.chdir File.join(__dir__, '..')

curr_tag, = Open3.capture2('git', 'describe', '--abbrev=0', '--match=v*')
curr_version = curr_tag.sub(/\Av/, '')
next_version = curr_version.to_i.succ.to_s
next_tag = "v#{next_version}"

Dir['*/lib/**/version.rb'].each do |path|
  content = File.read(path)
  content.gsub!(/VERSION = "\K[^"]+/) { next_version }
  File.write(path, content)
end

system('bundle', 'install', exception: true)

system('git', 'add', '-A')
system('git', 'commit', '-m', "Release v#{next_version}")
system('git', 'tag', '-s', '-m', "Version #{next_version}", next_tag)
