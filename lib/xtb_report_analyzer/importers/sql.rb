require_relative '../common/data'

module XTBReportAnalyzer
  module Importers
    module SQL
      def get_xtb_id(dtype)
        raise ArgumentError, "Invalid datatype" unless C_D::valid?(dtype)
        "SELECT #{C_D::get_xtb_id(dtype)} FROM #{C_D::get_table_name(dtype)}"
      end
    end
  end
end