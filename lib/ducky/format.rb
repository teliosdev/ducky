module Ducky
  module Format

    extend self

    def format(information)
      out = ""

      information[:head].each do |head|
        out << head << "\n"
      end

      body = ""
      information[:body].children.each do |child|
        content = word_wrap(child.content.gsub(/\s+/, " "))
        case child.name
        when "comment", "div"
        when "text"
          body << content
        when "p"
          body << content << "\n"
        when /h[1-6]/
          body << "\n\n" << content << "\n"
        when "pre"
          body << "\n\n    " <<
            child.content.split("\n").join("\n    ") << "\n\n"
        end
      end

      out << "\n\n" << body.strip << "\n\n" << information[:footer]
    end

    # thanks, Rails!
    def word_wrap(text, options = {})
      line_width = options.fetch(:line_width, 80)

      text.split("\n").collect! do |line|
        line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
      end * "\n"
    end
  end
end
