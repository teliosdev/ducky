module Ducky
  module Sources
    class Core < Source

      include ERB::Util

      def initialize(method, version)
        @method = method
        @version = version

        super(method)
      end

      def lookup
        elements = document.css(selector)
        information = {
          :head => [],
          :body => [],
          :source => "",
          :footer => "",
          :url => url
        }

        elements.each do |element|
          element.css(".method-heading").each do |call|
            information[:head] << call.inner_text.
              gsub("click to toggle source", "").strip
          end

          information[:body] = element.
            css('div:not(.method-source-code):not(.aliases)').last
          source = element.css('.method-source-code').each do |source|
            information[:source] = source.content
          end

          element.css('.aliases').each do |a|
            information[:footer] << a << "\n"
          end

          information[:footer].strip!
        end

        unless elements.any?
          handle_error
        else
          information
        end

      rescue Faraday::ResourceNotFound
        no_method!
      end

      private

      def source
        RUBY_DOC
      end

      def selector
        "#public-#{@type}-method-details " \
          "##{@message.gsub(/[\W]/, "-").gsub(/\A-/, "")}-method"
      end

      def url
        "/core-#{@version}/#{@receiver}.html"
      end

      def parent
        @_parent ||= document.css("#parent-class-section p.link a").
          first.content

      rescue
        super
      end
    end
  end
end
