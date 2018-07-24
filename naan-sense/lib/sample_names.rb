#!/usr/bin/env ruby


#load sample names from the base directory...
#later to be used in autocompletion and what not
require 'pathname'
require 'fileutils'

# drumkits = "/home/b08x/studio/resources/samples/drums/drumkits/**"
#
# Dir.glob(drumkits + "/*.{flac,wav}").each do |x|
#   perc = Pathname.new(x)
#
#   name = perc.basename
#
#
#   puts name.to_s.gsub(/#{perc.extname}/,'')
#
# end


#############################################
# drum_kits = Pathname.new("/home/b08x/studio/resources/samples/drums/drumkits/")
#
# drum_kits = drum_kits.children
#
# drum_kits.map { |x| x.to_s  }.each do |y|
#   sample_files = Dir.entries(y)
#   sample_files.sort!  {|x,y| x <=> y}
#   puts File.basename(y)
#   puts "-" * 20
#
#
#   sample_files.each do |file|
#     next if File.directory?(file)
#     next unless File.extname(file) =~ /wav|flac|aiff/
#     file_ext = File.extname(file)
#     sample_file = file.gsub(/#{file_ext}/,'')
#     puts sample_file
#   end
#   3.times do
#     puts "\n"
#   end
#
# end
#################################################

def print_sample_files(dir)
  sample_files = Dir.entries(dir)
  sample_files.sort!  {|x,y| x <=> y}
  puts File.basename(dir)
  puts "-" * 20


  sample_files.each do |file|
    next if File.directory?(file)
    next unless File.extname(file) =~ /wav|flac|aiff/
    file_ext = File.extname(file)
    sample_file = file.gsub(/#{file_ext}/,'')
    puts sample_file
  end
  3.times do
    puts "\n"
  end

end

pearl_kit = "/home/b08x/studio/resources/samples/drums/drumkits/AVL-RedZep-5-1.1/"

forzee_kit = "/home/b08x/studio/resources/samples/drums/drumkits/ForzeeStereo/"


print_sample_files(forzee_kit)


#

# sample_dir = Pathname.new("/home/b08x/studio/resources/samples")
#
# samples = Dir.glob(sample_dir + "**/*.{flac,wav,aiff}")
#
# puts samples
