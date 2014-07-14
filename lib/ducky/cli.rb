require "thor"

module Ducky
  class CLI < Thor

    desc "core METHOD [VERSION]",
      "lookup the given method in the given ruby version's core"
    def core(method, version = RUBY_VERSION)
      puts Ducky.lookup(:core, method, version)
    end

    desc "stdlib LIB METHOD [VERSION]",
      "lookup the given method in the given ruby version's stdlib"
    def stdlib(lib, method, version = RUBY_VERSION)
      puts Ducky.lookup(:stdlib, lib, method, version)
    end

    desc "gem NAME METHOD [VERSION]",
      "lookup the given method in the given gem version's source"
    def gem(name, method, version = :guess)
      puts Ducky.lookup(:gem, name, method, version)
    end

  end
end
