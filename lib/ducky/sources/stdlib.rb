module Ducky
  module Sources
    class StdLib < Core

      def initialize(lib, method, version)
        @lib = lib
        super(method, version)
      end

      private

      def url
        "/stdlib-#{version}/libdoc/#{@lib}/rdoc/#{receiver}.html"
      end

      def parent
        no_method!
      end
    end
  end
end
