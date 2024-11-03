require 'thor'
require_relative 'converters/xlsx_to_json'

module XTBReportAnalyzer
  class CLI < Thor
    desc "convertor XLSX_FILE", "Converts an XLSX file to JSON format"
    def convertor(xlsx_file)
      raise ArgumentError, "File does not exist" unless File.exist?(xlsx_file)
      raise ArgumentError, "File is not readable" unless File.readable?(xlsx_file)
      convertor = XTBReportAnalyzer::Convertors::XLSXToJSON.new(xlsx_file)
      puts convertor.get_json
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end
end