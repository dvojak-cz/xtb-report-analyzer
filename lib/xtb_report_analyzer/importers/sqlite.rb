require_relative '../common/data'

module XTBReportAnalyzer
  module Importers
    class SQLite

      included XTBReportAnalyzer::Importers::SQL

      attr_reader :path

      @@datatype = [:open_positions, :pending_orders, :cash_operations, :balance_operations]

      def initialize(path)
        @path = path
        @db ||= SQLite3::Database.new(path)
      end

      def get_xtb_id(dtatype) = @db.execute(get_xtb_id(dtatype)).flatten

      def open_positions
        db.execute("SELECT * FROM open_positions").map do |row|
          Models::OpenPosition.new(row)
        end
      end

      def pending_orders
        db.execute("SELECT * FROM pending_orders").map do |row|
          Models::PendingOrder.new(row)
        end
      end

      def cash_operations
        db.execute("SELECT * FROM cash_operations").map do |row|
          Models::CashOperation.new(row)
        end
      end

      def balance_operations
        db.execute("SELECT * FROM balance_operations").map do |row|
          Models::BalanceOperation.new(row)
        end
      end
    end
  end
end
