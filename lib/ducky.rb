require "ducky/version"
require "ducky/source"
require "ducky/sources"
require "ducky/cli"
require "ducky/format"

module Ducky

  SOURCES = {
    :core   => Sources::Core,
    :stdlib => Sources::StdLib,
    :gem    => Sources::Gem
  }

  def lookup(type, *args)
    source = SOURCES[type]
    Format.format source.new(*args).lookup

  rescue NoMethodError => e
    e.message
  end

  extend self

end
