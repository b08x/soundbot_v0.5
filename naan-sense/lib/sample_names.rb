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
drum_kits = Pathname.new("/home/b08x/studio/library/sfz/drums/")

drum_kits = drum_kits.children

drum_kits.map { |x| x.to_s  }.each do |y|

  folder_path = y
  p folder_path

  sample_files = Dir.entries(y)
  sample_files.sort!  {|x,y| x <=> y}

  puts File.basename(y)
  new_prefix = File.basename(y)
  new_prefix = new_prefix.downcase + "_"
  new_prefix = new_prefix.gsub(/-|\s/,"_")
  puts new_prefix
  puts "-" * 20


  sample_files.each do |file|
    next if File.directory?(file)
    next unless File.extname(file) =~ /wav|flac|aiff/


    #file = file.gsub(/^\d+/,"")
    #file = file.gsub(/-|\s|__|\+/,"_")
    # file_ext = File.extname(file)
    new_file_name = new_prefix + file
    new_file_name = new_file_name.gsub(/-|\s|__|\+/,"_")
    new_file_name = new_file_name.downcase

    old_name = folder_path + "/" + file
    new_name = folder_path + "/" + new_file_name


    File.rename(old_name,new_name)
    # sample_file = file.gsub(/#{file_ext}/,'')
    #
    # puts sample_file
  end
  3.times do
    puts "\n"
  end

end
#################################################

# def print_sample_files(dir)
#   sample_files = Dir.entries(dir)
#   sample_files.sort!  {|x,y| x <=> y}
#   puts File.basename(dir)
#   puts "-" * 20
#
#
#   sample_files.each do |file|
#     next if File.directory?(file)
#     next unless File.extname(file) =~ /wav|flac|aiff/
#
#     #file_ext = File.extname(file)
#     #sample_file = file.gsub(/#{file_ext}/,'')
#
#     puts File.(file)
#   end
#   3.times do
#     puts "\n"
#   end
#
# end
#
#
# forzee_kit = "/home/b08x/studio/library/sfz/drums/YamahaVintageKit/"
#
#
# print_sample_files(forzee_kit)

# conver to lower case
# replace spaces with underscore


#

# sample_dir = Pathname.new("/home/b08x/studio/resources/samples")
#
# samples = Dir.glob(sample_dir + "**/*.{flac,wav,aiff}")
#
# puts samples
