#!/usr/bin/env ruby

# find all the wav files, mix em down to mono

require 'pathname'
require 'tty-command'

home = ENV['HOME']

src = "/storage/samples"
dst = File.join(home, "studio", "sound_library", "samples")


# convert mp3 to wav
mp3glob = Dir.glob(src + "/**/*mp3")

mp3glob.each do |mp3|

	cmd = TTY::Command.new(printer: :pretty)

	path = Pathname.new(mp3)
	filename = path.basename.to_s.gsub(path.extname,'')

	#convert stereo mp3 to mono wav
	cmd.run("sox #{mp3} -c 1 -r 48k #{File.join(dst, filename + ".wav")}"

end


wavglob = Dir.glob(src + "/**/*wav")

wavglob.each do |wav|
	#create a pathname object with the full path of the file
	#/media/dm-1/b08x/Videos/screenaudio_20180826-13h12.wav
	srcfile = Pathname.new(wav)

	#one way to get the folder name where the wav rsides
	#["/media/dm-1/b08x/Videos/website_ruby_stuff", "20180901-22h13.wav"]
	dir, file = File.split(srcfile.cleanpath)

	#e.g.live_jack_session
	##<Pathname:website_ruby_stuff>
	folder_to_create = Pathname.new(dir).basename

	dst_folder = File.join(dst, folder_to_create.to_s)

	unless Dir.exists?(dst_folder)
		Dir.mkdir (dst_folder)
	end

	puts "mixing and moving #{srcfile.to_s} to #{File.join(dst_folder, file)} "

	# mix down to mono
	cmd = TTY::Command.new(printer: :pretty)

	cmd.run("sox #{srcfile.to_s} #{File.join(dst_folder, file)} remix 1,2")

	#ensure 48k rate

	#normalize

end


#TODO remove src file
