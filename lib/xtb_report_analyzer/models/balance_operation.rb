module XTBReportAnalyzer
  module Models
    class BalanceOperation
      attr_accessor :id, :type, :time, :comment, :amount

      def initialize(attributes = {})
        attributes = attributes.transform_keys(&:to_sym)
        @id = attributes[:id]
        @type = attributes[:type]
        @time = attributes[:time]
        @comment = attributes[:comment]
        @amount = attributes[:amount]
      end
    end
  end
end
