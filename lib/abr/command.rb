require 'abr'
require 'thor'

module Abr
  class Command < Thor
    desc "test -i=[input file path] -o=[output file path]", "performance tests using apache bench"
    option :input_file, aliases: 'i', required: true
    option :output_file, aliases: 'o'
    def test
      Abr.test(options)
    end
  end
end

