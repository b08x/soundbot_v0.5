#!/usr/bin/env ruby

# compatible with ruby 1.9, 2.0 and jruby
require 'rubygems'
require 'osc-ruby'
require 'osc-ruby/em_server'

@server = OSC::Server.new( 3333 )
#@client = OSC::Client.new( 'localhost', 3333 )

# @server.add_method '/greeting' do | message |
#   puts "#{message.ip_address}:#{message.ip_port} -- #{message.address} -- #{message.to_a}"
# end

Thread.new do
  @server.run
end

#@client.send( OSC::Message.new( "/greeting" , "hullo!" ))
