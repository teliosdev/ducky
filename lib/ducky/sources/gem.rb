module Ducky
  module Sources
    class Gem < Source

      def initialize(name, method, version = :guess)
        @name = name
        @method = method
        @version = version

        super(method)
      end

      def lookup
        methods = document.css('#method_details .method_details')
        no_method! unless methods.any?

        methods.each do |method|
          method.css('.signature').each do |sig|
            information[:head] << sig.inner_text.strip
          end

          information[:body] = document.
            css('.docstring .discussion').last

          information[:footer] =
            create_footer(document.css('.tags').last)

          information[:source] = document.
            css('.source_code pre.code').last.inner_text
        end

        information

      rescue Faraday::ResourceNotFound
        no_method!
      end

      private

      def create_footer(tags)
        return unless tags
        out = ""

        tags.children.each do |tag|
          case tag.name
          when "p"
            out << tag.inner_text.strip
          when "ul"
            tag.children.each do |li|
              li.children.each do |span|
                content = span.inner_text.gsub(/\s+/, " ")

                out << Format.word_wrap(content, line_width: 71)
              end
              out << "\n"

            end

          end

        end

        out
      end

      def source
        RUBYDOC_INFO
      end

      def information
        @_information ||= {
          :head => [],
          :body => [],
          :source => "",
          :footer => "",
          :url => url
        }
      end

      def version
        @_version ||= begin
          if @version == :guess
            response = RUBY_GEMS.get("/api/v1/gems/#{@name}.json")
            response.body["version"]
          else
            @version
          end
        end
      end

      def url
        part = "/gems/#{@name}/#{version}/#{@receiver}"
        if @type == :class
          part << "."
        else
          part << ":"
        end

        part << @message
      end
    end
  end
end
