require 'tty-which'


sonic_pi_tool = TTY::Which.which("sonic-pi-tool")

seshmon_home = "/home/b08x/studio/seshmon"
current_date = Time.now.strftime('%Y-%m-%d')

God.watch do |w|
  w.name = "soniclogs"
  w.start = "#{sonic_pi_tool} logs"
  w.log = File.join(seshmon_home, "/logs/seshmon_sonic-#{current_date}.log")
  w.keepalive
end

God.watch do |w|
  w.name = "sonicpi"
  w.start = "#{sonic_pi_tool} start-server"
  w.log = File.join(seshmon_home, "/logs/sonic-#{current_date}.log")
  w.keepalive
end
