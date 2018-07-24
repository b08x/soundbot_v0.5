#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'

program :name, 'something'
program :version, '0.0.1'
program :description, 'audio session manager'

command :open do |c|
  c.syntax = 'something open [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Something::Commands::Open
  end
end

command :this, do |c|
  c.syntax = 'something this, [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Something::Commands::This,
  end
end

command :open do |c|
  c.syntax = 'something open [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Something::Commands::Open
  end
end

command :that do |c|
  c.syntax = 'something that [options]'
  c.summary = ''
  c.description = ''
  c.example 'description', 'command example'
  c.option '--some-switch', 'Some switch that does something'
  c.action do |args, options|
    # Do something or c.when_called Something::Commands::That
  end
end

