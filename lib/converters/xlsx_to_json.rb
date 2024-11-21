# lib/xtb_report_analyzer/converters/xlsx_to_json.rb
require "json"
require "roo"
require_relative "../common/data"
C_D = Common::Data

module Convertors
  class XLSXToJSON
    @@TABLE_HEADERS = {
      C_D::CLOSED_POSITIONS => {
        :position => "Position", :symbol => "Symbol", :type => "Type", :volume => "Volume", :open_time => "Open time",
        :open_price => "Open price", :close_time => "Close time", :close_price => "Close price",
        :open_origin => "Open origin", :close_origin => "Close origin", :purchuse_value => "Purchase value",
        :sale_value => "Sale value", :sl => "SL", :tp => "TP", :margin => "Margin", :commission => "Commission",
        :swap => "Swap", :rollover => "Rollover", :gross_pl_comment => "Gross P/L", :comment => "Comment",
      },
      C_D::OPEN_POSITIONS => {
        :position => "Position", :symbol => "Symbol", :type => "Type", :volume => "Volume", :open_time => "Open time",
        :open_price => "Open price", :market_price => "Market price", :purchase_value => "Purchase value",
        :sl => "SL", :tp => "TP", :margin => "Margin", :commission => "Commission", :swap => "Swap",
        :rollover => "Rollover", :gross_pl => "Gross P/L", :comment => "Comment",
      },
      C_D::PENDING_ORDERS => {
        :id => "ID", :symbol => "Symbol", :purchase_value => "Purchase value", :nominal_value => "Nominal Value",
        :price => "Price", :margin => "Margin", :type => "Type", :order => "Order", :side => "side", :sl => "SL",
        :tp => "TP", :open_time => "Open time",
      },
      C_D::CASH_OPERATIONS => {
        :id => "ID", :type => "Type", :time => "Time", :comment => "Comment", :symbol => "Symbol", :amount => "Amount",
      },
      C_D::BALANCE_OPERATIONS => {
        :id => "ID", :type => "Type", :time => "Time", :comment => "Comment", :amount => "Amount",
      },
    }
    @@SHEET_NAMES = {
      C_D::CLOSED_POSITIONS => "CLOSED POSITION HISTORY",
      C_D::OPEN_POSITIONS => "OPEN POSITION 20102024",
      C_D::PENDING_ORDERS => "PENDING ORDERS HISTORY ",
      C_D::CASH_OPERATIONS => "CASH OPERATION HISTORY",
      C_D::BALANCE_OPERATIONS => "BALANCE OPERATION HISTORY MT",
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
      raise ArgumentError, "Unsupported sheet" unless C_D::valid?(sheet)
      @sheet.sheet(@@SHEET_NAMES[sheet]).parse(**@@TABLE_HEADERS[sheet]).reject { |r| r[:position] == "Total" }
    end

    def parse_workbook()
      @sheet ||= Roo::Spreadsheet.open(@file_path)
      raise ArgumentError, "Unsupported workbook (expected sheets #{@@SHEET_NAMES.values}" unless @sheet.sheets.sort == @@SHEET_NAMES.values.sort
      @data ||= @@SHEET_NAMES.keys.map { |sheet| [sheet, parse_sheet(sheet)] }.to_h
      transform_data
    end

    def transform_data()
      # in all values in @data, rename key type to transactino_type
      @data.each do |sheet, records|
        records.each do |record|
          record[:transaction_type] = record.delete(:type)
        end
      end

      @data[C_D::OPEN_POSITIONS].each { |x| x[:id] = x.delete(:position) }
      @data[C_D::CLOSED_POSITIONS].each { |x| x[:id] = x.delete(:position) }
    end
  end
end
