module XTBReportAnalyzer
  module Models
    class ClosedPosition
      attr_accessor :position, :symbol, :type, :volume, :open_time, :open_price, :close_time, :close_price,
                    :open_origin, :close_origin, :purchase_value, :sale_value, :sl, :tp, :margin, :commission,
                    :swap, :rollover, :gross_pl_comment, :comment

      def initialize(attributes = {})
        attributes = attributes.transform_keys(&:to_sym)
        @position = attributes[:position]
        @symbol = attributes[:symbol]
        @type = attributes[:type]
        @volume = attributes[:volume]
        @open_time = attributes[:open_time]
        @open_price = attributes[:open_price]
        @close_time = attributes[:close_time]
        @close_price = attributes[:close_price]
        @open_origin = attributes[:open_origin]
        @close_origin = attributes[:close_origin]
        @purchase_value = attributes[:purchase_value]
        @sale_value = attributes[:sale_value]
        @sl = attributes[:sl]
        @tp = attributes[:tp]
        @margin = attributes[:margin]
        @commission = attributes[:commission]
        @swap = attributes[:swap]
        @rollover = attributes[:rollover]
        @gross_pl_comment = attributes[:gross_pl_comment]
        @comment = attributes[:comment]
      end
    end
  end
end
