#!/usr/bin/env ruby

require 'pathname'
require 'musicxml'

#mxml_file = Pathname.new(File.join(Dir.pwd, "/",ARGV))

song_file = "/home/b08x/studio/sonata02.xml"

score = MusicXML::Parser.new(song_file).parse



#list out the parts
#score.part_list

#use the first part
#score.part[0].methods

#measure 0 will give key sig and time/tempo info
#score.part[0].measure[0]

#first part, fourth measure
#score.part[0].measure[4]
