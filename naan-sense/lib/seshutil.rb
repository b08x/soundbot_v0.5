#!/usr/bin/env ruby
# this file contains modules used throughout the app. ideally these can be called as standalone instances
# http://www.intridea.com/blog/2010/4/19/ruby-quick-tip-instant-utility-modules

module SeshConfig
  module_function

  require 'yaml'

  def load_config
    config = YAML::load(File.open("#{APP_ROOT}/config.yml"))

    return config
  end
end

# module for log format adapated from https://github.com/puppetlabs/Razor-Microkernel/blob/master/razor_microkernel/logging.rb
module Logging
  module_function

  require 'logger'

  @loggers = {}

  def logger

    classname = self.class.name
    methodname = caller[0][/`([^']*)'/, 1]
    @logger ||= Logging.logger_for(classname, methodname)
    @logger.progname = "#{classname}\##{methodname}"
    @logger

  end

  class << self

    def get_log_level

      test = Logger::DEBUG
      test

    end

    def logger_for(classname, methodname)

      @loggers[classname] ||= configure_logger_for(classname, methodname)

    end

    def configure_logger_for(classname, methodname)

      current_date = Time.now.strftime('%Y-%m-%d')
      log_file = File.join(LOG_DIR, "seshmon-#{current_date}.log")
      logger = Logger.new(log_file, LOG_MAX_FILES, LOG_MAX_SIZE)
      logger.level = get_log_level
      logger

    end

  end

end


LOG_DIR = File.join(APP_ROOT, '/logs')
LOG_LEVEL = Logger::DEBUG
LOG_MAX_SIZE = 6145728
LOG_MAX_FILES = 10
