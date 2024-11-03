# lib/xtb_report_analyzer/converters/xlsx_to_json.rb
require 'json'
require 'roo'

module XTBReportAnalyzer
  module Convertors
    class XLSXToJSON
      @@TABLE_HEADERS = {
        :closedPositions => {
          :position => "Position", :symbol => "Symbol", :type => "Type", :volume => "Volume", :open_time => "Open time",
          :open_price => "Open price", :close_time => "Close time", :close_price => "Close price",
          :open_origin => "Open origin", :close_origin => "Close origin", :purchuse_value => "Purchase value",
          :sale_value => "Sale value", :sl => "SL", :tp => "TP", :margin => "Margin", :commission => "Commission",
          :swap => "Swap", :rollover => "Rollover", :gross_pl_comment => "Gross P/L", :comment => "Comment"
        },
        :openPositions => {
          :position => "Position", :symbol => "Symbol", :type => "Type", :volume => "Volume", :open_time => "Open time",
          :open_price => "Open price", :market_price => "Market price", :purchase_value => "Purchase value",
          :sl => "SL", :tp => "TP", :margin => "Margin", :commission => "Commission", :swap => "Swap",
          :rollover => "Rollover", :gross_pl => "Gross P/L", :comment => "Comment"
        },
        :pendingOrders => {
          :id => "ID", :symbol => "Symbol", :purchase_value => "Purchase value", :nominal_value => "Nominal Value",
          :price => "Price", :margin => "Margin", :type => "Type", :order => "Order", :side => "side", :sl => "SL",
          :tp => "TP", :open_time => "Open time"
        },
        :cashOperations => {
          :id => "ID", :type => "Type", :time => "Time", :comment => "Comment", :symbol => "Symbol", :amount => "Amount"
        },
        :balanceOperations => {
          :id => "ID", :type => "Type", :time => "Time", :comment => "Comment", :amount => "Amount"
        }
      }
      @@SHEET_NAMES = {
        :closedPositions => "CLOSED POSITION HISTORY",
        :openPositions => "OPEN POSITION 20102024",
        :pendingOrders => "PENDING ORDERS HISTORY ",
        :cashOperations => "CASH OPERATION HISTORY",
        :balanceOperations => "BALANCE OPERATION HISTORY MT"
      }

      def initialize(file_path)
        @file_path = file_path
      end

      def get_data
        parse_workbook if @data.nil?
        @data
      end

      def get_json
        get_data.to_json
      end

      private

      def parse_sheet(sheet)
        raise ArgumentError, "Unsupported sheet" unless @@SHEET_NAMES.key?(sheet)
        @sheet.sheet(@@SHEET_NAMES[sheet]).parse(**@@TABLE_HEADERS[sheet]).reject { |r| r[:position] == "Total" }
      end

      def parse_workbook()
        @sheet ||= Roo::Spreadsheet.open(@file_path)
        raise ArgumentError, "Unsupported workbook (expected sheets #{@@SHEET_NAMES.values}" unless @sheet.sheets.sort == @@SHEET_NAMES.values.sort
        @data ||= @@SHEET_NAMES.keys.map { |sheet| [sheet, parse_sheet(sheet)] }.to_h
      end
    end
  end
end