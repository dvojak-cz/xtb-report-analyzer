module XTBReportAnalyzer
  module Models
    class OpenPosition
      attr_accessor :position, :symbol, :type, :volume, :open_time, :open_price, :market_price, :purchase_value,
                    :sl, :tp, :margin, :commission, :swap, :rollover, :gross_pl, :comment

      def initialize(attributes = {})
        attributes = attributes.transform_keys(&:to_sym)
        @position = attributes[:position]
        @symbol = attributes[:symbol]
        @type = attributes[:type]
        @volume = attributes[:volume]
        @open_time = attributes[:open_time]
        @open_price = attributes[:open_price]
        @market_price = attributes[:market_price]
        @purchase_value = attributes[:purchase_value]
        @sl = attributes[:sl]
        @tp = attributes[:tp]
        @margin = attributes[:margin]
        @commission = attributes[:commission]
        @swap = attributes[:swap]
        @rollover = attributes[:rollover]
        @gross_pl = attributes[:gross_pl]
        @comment = attributes[:comment]
      end
    end
  end
end
