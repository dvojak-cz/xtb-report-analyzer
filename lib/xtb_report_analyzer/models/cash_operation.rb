module XTBReportAnalyzer
  module Models
    class CashOperation
      attr_accessor :id, :type, :time, :comment, :symbol, :amount

      def initialize(attributes = {})
        attributes = attributes.transform_keys(&:to_sym)
        @id = attributes[:id]
        @type = attributes[:type]
        @time = attributes[:time]
        @comment = attributes[:comment]
        @symbol = attributes[:symbol]
        @amount = attributes[:amount]
      end
    end
  end
end
