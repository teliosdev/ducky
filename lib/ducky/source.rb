require "nokogiri"
require "erb"

module Ducky
  class Source

    include ERB::Util

    def initialize(method)
      @method = method
      @receiver, @type, @message = split_method
    end

    def response
      @_response ||= source.get(url)
    end

    def document
      @_document ||= Nokogiri::HTML(response.body)
    end

    def lookup
      raise NotImplementedError
    end

    private

    def url
      raise NotImplementedError
    end

    def handle_error
      core = self.class.
        new("#{@method.gsub(@receiver, parent)}", version)
      core.lookup
    rescue NoMethodError
      no_method!
    end

    def parent
      no_method!
    end

    def no_method!
      raise NoMethodError, "No method named #{@method}"
    end

    def split_method
      match = @method.match(/\A(.*)(\.|\#|\:\:)(.*?)\z/)
      no_method! unless match

      base = if match[1].empty?
        "Object"
      else
        match[1]
      end

      type = case match[2]
        when ".", "::"
          :class
        when "#"
          :instance
        end

      [
        base.gsub("::", "/"),
        type,
        url_encode(match[3])
      ]
    end
  end
end
