#!/usr/bin/env ruby

# take playlist files generated from mixx, in .csv form, parse out the file paths to the samples
# we'd like to use, then create a folder with symlinks to the files under the project directory...

require 'csv'
require 'pathname'
require 'fileutils'
require 'tty-command'


# place the exported csv file from mixxx into the directory the samples should go in
# then run ./sample_link.rb playlist.csv

def link_samps(playlist)

  CSV.foreach(playlist, :headers => true, :header_converters => :symbol) do |row|

      samp_path = Pathname.new(row[:location])

      linked_sample = samp_path.basename.to_s
      linked_sample_ext = samp_path.extname.to_s

      #linked_sample.gsub!(/\s|-|\.|\)|\(|\'/, "").strip
      # TODO better file naming scheme
      linked_sample = linked_sample.gsub(/\s|-|\)|\(|\'|#{linked_sample_ext}/, "").strip

      linked_sample_out = File.join(playlist.dirname, "/", linked_sample + ".wav")

      unless File.exists?(linked_sample_out)
          og_path = samp_path.cleanpath
          @cmd.run("ffmpeg -i", "#{og_path}", "-ar 48000", "#{linked_sample_out}")    
      end

  end

end

@cmd = TTY::Command.new

playlist = Pathname.new(File.join(Dir.pwd, "/",ARGV))

link_samps(playlist)

# samples should really not have any spaces or special chars in the file name....
