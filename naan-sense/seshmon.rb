#!/usr/bin/env ruby

APP_ROOT = "/home/b08/workspace/seshmon"
$LOAD_PATH.push APP_ROOT + '/lib'


require 'highline/import'
require 'tty-command'
require 'tty-which'
require 'tty-prompt'
require 'tty-pager'
require 'god'
require 'i3ipc'
require 'seshutil.rb'
require 'celluloid'
require 'forkoff'

config = SeshConfig.load_config

SONIC_HOME = config[:sonicpisrc]

sptool = TTY::Which.which("sonic-pi-tool")
jackd = TTY::Which.which("jackd")
jack_control = TTY::Which.which("jack_control")
god = TTY::Which.which("god")
non_sesh = TTY::Which.which("non-session-manager")


include Logging

# task_prompt = TTY::Prompt.new
# task_choices =['input_setup']
# @task_result = task_prompt.multi_select("select things to be done", task_choices)
#
#
# group_prompt = TTY::Prompt.new
# group_choices = ['start_jack', 'meters', 'sonic', 'guitarix', 'zita_tools']
#
# @group_result = group_prompt.multi_select("select apps", group_choices)

#@cmd = TTY::Command.new(printer: :pretty, pty: true)
#@i3 = I3Ipc::Connection.new




def start_jack

  cmd = TTY::Command.new(printer: :pretty)
  cmd.run("jack_control start \
  dps device 'hw:0' \
  dps rate 48000 \
  dps period 512 \
  dps nperiods 2 \
  dps midi-driver seq \
  eps driver alsa \
  eps realtime True \
  eps realtime-priority 80 \
  eps verbose True \
  eps client-timeout 1000")

end


def start_sonic

  #command1="sonic-pi-tool logs; bash"
  #symlink this to /home/bin
  #command2="/home/b08x/workspace/sonic-pi/app/server/ruby/bin/sonic-pi-server.rb; bash"
  #command2="sonic-pi-server.rb; bash"

  # Modify terminator's config
  #@cmd.run("sed -i.bak 's/COMMAND1/#{command1}/ ; s/COMMAND2/#{command2}/' ~/.config/terminator/config")

  @cmd.run('terminator -l "sonicstuff"')

  ## Return the original config file
  #`mv ~/.config/terminator/config.bak ~/.config/terminator/config`

end

def launch_guitarix

  puts "launching guitarix"

  system("nohup guitarix &")


  @i3.command('[title="(?i)Guitarix"] move workspace 2')
end

def base_board

  # puts "launching limiter"
  # system("nohup zita-dpl1 -k 2 2>&1 /dev/null &" )
  # sleep 2

  puts "launching meter"
  system("nohup x42-meter 1 2>&1 /dev/null &")

  sleep 1

  puts "launching eq"
  system("nohup x42-fil4 2>&1 /dev/null &")



  #
  # puts "now moving to workspace 10"
  #

  #
  #@i3.command('[class="(?i)zita-dpl1"] move workspace 10')
  @i3.command('[title="(?i)Meter"] move workspace 10')
  @i3.command('[title="(?i)x42-eq"] move workspace 10')
  #

  @cmd.run('terminator -e "njconnect"')

end

def zita_tools(tool)

  tool.each do |t|
    case t
    when "reverb"
      puts "launching zita reverb...yay!"

      system("nohup zita-rev1 2>&1 /dev/null &" )


      sleep 1

      @i3.command('[class="(?i)zita-rev1"] move workspace 10')

    when "limiter"
      puts "launching zita limiter...woooo!"

      system("nohup zita-dpl1 -k 2 2>&1 /dev/null &" )

      sleep 1

      @i3.command('[class="(?i)zita-dpl1"] move workspace 10')
    end
  end

end

def load_drums
  @cmd.run('jalv.gtk http://github.com/nicklan/drmr')
end
################################################################################

## TODO: convert drumkits into sf2 to be used in qsynth




# nann_result = TTY::Command.new(printer: :null, binmode: true).run("non-mixer")
# if nann_result.success?
#   $stderr.puts("hey, non mixer launched. awesome. \nn #{nann_result.stdout} #{nann_result.stderr}")
# end
#
#
# sooper_looper = TTY::Command.new(printer: :null).run("slgui")
# if sooper_looper.success?
#   $stderr.puts("hey, sooper_looper launched. awesome. \n #{sooper_looper.stdout} #{sooper_looper.stderr}")
# end

# class Stuff
#   include Celluloid
#
#   def initialize(appname)
#     @appname = appname
#   end
#
#   def load_app_and_print
#     lp = TTY::Command.new
#     lp.run("#{@appname}")
#   end
#
# end
#
# apps = ["slgui", "non-mixer"]
#
# apps.each do |a|
#   al = Stuff.new a
#   al.load_app_and_print
# end


logger = Logger.new('dev.log')



def load_app(apps)
threads = []
apps.each do |i|
  say("loading #{i}")
  th = Thread.new do
    cmd = TTY::Command.new(printer: :pretty, output: logger, color: true)
    cmd.run("#{i}")
  end
  threads << th
  sleep 2
end
threads.each(&:join)

end

first_prompt = TTY::Prompt.new
first_choices = ['start session', 'exit']
@first_result = first_prompt.multi_select("start here", first_choices)

if @first_result.include?("start session")
  load_app(["/usr/bin/jackd -v -t2000 -dalsa -r48000 -p512 -n2 -Xseq -D -Chw:PCH,0 -Phw:PCH", "a2jmidid -e", "alsa_in -j 'cammic' -d hw:C920 -r 32000", "alsa_in -j 'stickmic' -d hw:AK5370 -c 1", "non-session-manager"])
elsif @first_result.include?("exit")
  say("exiting")
  system("pkill -9 jackd")
  exit
end

#if start session is selected, after apps are loaded, go back to the "main screen"

## TODO: get pids of launched apps

#calfjackhost --load presets/calf/calf_ms_rv_eq





#FIXME: if jackd is already running when asked to start it, dont do this.
# /home/b08/.rvm/gems/ruby-2.4.1@seshmon/gems/tty-command-0.7.0/lib/tty/command.rb:105:in `run': Running `/usr/bin/jackd -v -t2000 -dalsa -r48000 -p512 -n2 -Xseq -D -Chw:PCH,0 -Phw:PCH` failed with (T
# TY::Command::ExitError)
#   exit status: 255
#   stdout: jackdmp 1.9.12







#---------------------
# lp = TTY::Command.new
#
# %w(slgui non-mixer).forkoff! do |x|
#   lp.run("#{x}")
#   puts "#{Process.pid}"
# end






#TODO
#THIS:
#/home/b08x/.rvm/gems/ruby-2.4.1@seshmon/gems/tty-command-0.7.0/lib/tty/command.rb:105:in `run': Running `jack_control status` failed with (TTY::Command::ExitError)
#  exit status: 1
#  stdout: --- status
#********
# out, err = @cmd.run("jack_control status")
#
# if out.include?("started")
#   puts "jack already started...moving on"
# else
#   start_jack
#   sleep 2
# end







# if @group_result.include?("sonic")
#
#   start_sonic
#   sleep 10
#
# end
#
# if @group_result.include?("guitarix")
#   launch_guitarix
#   sleep 4
# end
#
# if @group_result.include?("meters")
#   base_board
#   sleep 4
# end
#
# if @group_result.include?("zita_tools")
#   prompt = TTY::Prompt.new
#   choices = ['reverb', 'limiter']
#
#   result = prompt.multi_select("select zita apps to launch", choices)
#
#   zita_tools(result)
#
# end
#
# if @task_result.include?("input_setup")
#   prompt = TTY::Prompt.new
#   choices = ['mic_front', 'line_in_back']
#
#   result = prompt.multi_select("which inputs need setting up in addition to the default of 'TODO: live variable'", choices)
#
#
#   #TODO
#   # a bunch of stuff...
#
#   result.each do |x|
#     case x
#     when 'mic_front'
#       #@cmd.run("nohup alsa_in -j 'gitar' -d 'hw:0,2' 2>&1 /dev/null &")
#       system("nohup alsa_in -j 'gitar' -d 'hw:0,2' 2>&1 /dev/null &" )
#     when 'line_in_back'
#       #@cmd.run("nohup alsa_in -j 'omnimic' -d 'hw:0,0' 2>&1 /dev/null &")
#       system("nohup alsa_in -j 'omnimic' -d 'hw:0,0' 2>&1 /dev/null &" )
#     end
#   end
# end


# #exec("god -c #{APP_ROOT}/seshmon.god -D")
#
# #@cmd.run("urxvt -e #{sptool} logs")
#
# exec("urxvt -e #{sptool} logs")
# exec("urxvt -e #{sptool} start-server")
#
# #@cmd.run("urxvt -e #{sptool} start-server")
#
# # start jack patch thingy
#


#
# @cmd.run("deadbeef")

#@cmd.run("atom /home/b08x/studio/seshmon")





# load the layout for limiter, meter and eq

# meter_space = "~/studio/seshmon/@i3spaces/workspace-10.json"
#
# @i3.command("workspace 10; append_layout #{meter_space}")

#
#






# non-mixer
#
#
# #carla might need god
# carla
#
#
# qsampler
