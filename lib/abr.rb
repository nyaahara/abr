require "abr/version"
require 'active_model'
require 'csv'
require 'nkf'

module Abr
  def self.test(options)
    input_file = options[:input_file]
    output_file = options[:output_file] || 'ab_result.csv'
    interval = options[:interval]&.to_i || 10

    result = open(input_file).map do |line|
      next unless line[0..1] == 'ab'
      result = {}
      IO.popen(line) do |io|
        while str = io.gets
          next if str.include?('This is ApacheBench')
          scan_result = str.scan(/^(.+):\s+(.+)/)
          if scan_result.length > 0
            key = scan_result[0][0]
            value = scan_result[0][1]

            if result.keys.last == 'Failed requests' && result[result.keys.last] != '0'
              result[result.keys.last] = "#{result[result.keys.last]}#{value}"
              next
            end

            key = "#{key}+" if result.has_key?(key)
            case key
            when 'Connect', 'Processing', 'Waiting', 'Total'
              values = value.split(' ').map {|val| val.strip}
              result["#{key} min"] = values[0]
              result["#{key} mean"] = values[1]
              result["#{key} [+/-sd]"] = values[2]
              result["#{key} median"] = values[3]
              result["#{key} max"] = values[4]
            else
              result[key] = value
            end
          end
        end
      end
      sleep interval
      result
    end

    headers = result.map {|list| list.keys}.flatten.uniq
    CSV.open(output_file, 'w') do |csv|
      csv << headers
      result.each do |r|
        csv << headers.map {|column_name| r[column_name] || '---'}
      end
    end
  end
end
