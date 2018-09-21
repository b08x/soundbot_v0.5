#!/usr/bin/env ruby

#given a directory;

#convert files to flac 48k

#remove whitespaces/characters from file name

#prefix with something depending on#
#  type: vocal or instrumental

#normailize
require 'pathname'
require 'fileutils'
require 'highline/import'
require 'tty-command'
require 'tty-which'
require 'tty-prompt'
require 'tty-pager'

drum_kits = Pathname.new("/home/b08x/studio/sound_library/instruments/drumsandpercussion/drums")

#drum_kits.map { |x| x.to_s }.each do |y|

drum_kits.children.each do |y|

  drumdir = y.basename

  FileUtils.cd(y, verbose: true) do
    cmd = TTY::Command.new(printer: :pretty)
    cmd.run("makesfz -s -k c3 -m all -f flac -n #{drumdir}")
  end

end


#pacpl -v -t flac -r -o wav --fcomp 5 --normalize --delete --freq 48000 --channels 1 drums/
