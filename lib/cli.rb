require "thor"
require_relative "converters/xlsx_to_json"
require_relative "models/balance_operation"
require_relative "models/cash_operation"
require_relative "models/closed_position"
require_relative "models/open_position"
require_relative "models/pending_order"
require_relative "common/data"
require "json"
require "yaml"
require "active_record"
ActiveRecord::Base.establish_connection(YAML.load_file("config/database.yml"))

C_D = Common::Data

class CLI < Thor
  desc "convertor XLSX_FILE", "Converts an XLSX file to JSON format"

  def convertor(xlsx_file)
    raise ArgumentError, "File does not exist" unless File.exist?(xlsx_file)
    raise ArgumentError, "File is not readable" unless File.readable?(xlsx_file)
    convertor = Convertors::XLSXToJSON.new(xlsx_file)
    puts convertor.get_json
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
  end

  desc "import DB_FILE", "Imports JSON data from a file or stdin"
  method_option :file, aliases: "-f", required: true, desc: "Path to JSON file or '-' for stdin"

  def import()
    json_data = options[:file] == "-" ? STDIN.read : File.read(options[:file])
    records = JSON.parse(json_data).transform_keys(&:to_sym)
    raise ArgumentError, "Invalid JSON format" unless records.keys.sort == C_D::all_dtypes.sort

    records.each do |dtype, objects|
      model_class = case dtype
        when C_D::BALANCE_OPERATIONS then Models::BalanceOperation
        when C_D::CASH_OPERATIONS then Models::CashOperation
        when C_D::CLOSED_POSITIONS then Models::ClosedPosition
        when C_D::OPEN_POSITIONS then Models::OpenPosition
        when C_D::PENDING_ORDERS then Models::PendingOrder
        end

      json_ids = objects.map { |r| r["id"] }

      objects.each do |r|
        record = model_class.find_by(id: r["id"])
        if record
          record.update(r)
        else
          model_class.create(r)
        end
      end
      model_class.where.not(id: json_ids).destroy_all
    end
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    raise e
  end
end
