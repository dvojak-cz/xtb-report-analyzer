require 'thor'
require_relative 'converters/xlsx_to_json'
require_relative 'models/balance_operation'
require_relative 'models/cash_operation'
require_relative 'models/closed_position'
require_relative 'models/open_position'
require_relative 'models/pending_order'
require_relative 'common/data'


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
      raise e
    end

    desc "import -f <file>", "Imports JSON data from a file or stdin"
    method_option :file, aliases: "-f", required: true, desc: "Path to JSON file or '-' for stdin"
    def import
      json_data = options[:file] == '-' ? STDIN.read : File.read(options[:file])
      records = JSON.parse(json_data).transform_keys(&:to_sym)
      raise ArgumentError, "Invalid JSON format" unless records.keys.sort == C_D::all_dtypes.sort
      data = {
        C_D::CASH_OPERATIONS => records[C_D::CLOSED_POSITIONS].map { |r| XTBReportAnalyzer::Models::ClosedPosition.new(r) },
        C_D::OPEN_POSITIONS => records[C_D::OPEN_POSITIONS].map { |r| XTBReportAnalyzer::Models::OpenPosition.new(r) },
        C_D::PENDING_ORDERS => records[C_D::PENDING_ORDERS].map { |r| XTBReportAnalyzer::Models::PendingOrder.new(r) },
        C_D::CASH_OPERATIONS => records[C_D::CASH_OPERATIONS].map { |r| XTBReportAnalyzer::Models::CashOperation.new(r) },
        C_D::BALANCE_OPERATIONS => records[C_D::BALANCE_OPERATIONS].map { |r| XTBReportAnalyzer::Models::BalanceOperation.new(r) }
      }
      p data
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
      raise e
    end

  end
end