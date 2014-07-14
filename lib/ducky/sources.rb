require "faraday"
require "faraday_middleware"
require "ducky/sources/core"
require "ducky/sources/gem"
require "ducky/sources/stdlib"

module Ducky
  module Sources

    RUBY_DOC = Faraday.new(:url => "http://ruby-doc.org") do |conn|
      conn.use Faraday::Response::RaiseError
      conn.adapter Faraday.default_adapter
    end


    RUBYDOC_INFO = Faraday.new(:url => "http://rubydoc.info") do |conn|
      conn.use Faraday::Response::RaiseError
      conn.adapter Faraday.default_adapter
    end

    RUBY_GEMS = Faraday.new(:url => "http://rubygems.org") do |conn|
      conn.use Faraday::Response::RaiseError
      conn.response :json
      conn.adapter Faraday.default_adapter
    end

  end
end
