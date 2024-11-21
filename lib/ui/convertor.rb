module Convertor
  def self.to_table(table, columns)
    raise InvalidArgumentError, "Table must be an array" unless table.is_a?(Array)
    raise InvalidArgumentError, "Columns must be an array" unless columns.is_a?(Array)
    raise InvalidArgumentError, "Columns must not be empty" if columns.empty?

    res = []
    table.each do |object|
      res << columns.map { |column| object[column] }
    end
    return [["NaN"] * columns.length] if res.empty?
    res
  end
end
