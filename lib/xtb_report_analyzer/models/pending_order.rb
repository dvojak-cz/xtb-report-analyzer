module XTBReportAnalyzer
  module Models
    class PendingOrder
      attr_accessor :id, :symbol, :purchase_value, :nominal_value, :price, :margin, :type, :order, :side, :sl, :tp, :open_time

      def initialize(attributes = {})
        attributes = attributes.transform_keys(&:to_sym)
        @id = attributes[:id]
        @symbol = attributes[:symbol]
        @purchase_value = attributes[:purchase_value]
        @nominal_value = attributes[:nominal_value]
        @price = attributes[:price]
        @margin = attributes[:margin]
        @type = attributes[:type]
        @order = attributes[:order]
        @side = attributes[:side]
        @sl = attributes[:sl]
        @tp = attributes[:tp]
        @open_time = attributes[:open_time]
      end
    end
  end
end
