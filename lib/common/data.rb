module Common
  module Data
    CLOSED_POSITIONS = :closed_positions
    OPEN_POSITIONS = :open_positions
    PENDING_ORDERS = :pending_orders
    CASH_OPERATIONS = :cash_operations
    BALANCE_OPERATIONS = :balance_operations

    DESCRIPTIONS = {
      CLOSED_POSITIONS => "Closed positions",
      OPEN_POSITIONS => "Open positions",
      PENDING_ORDERS => "Pending orders",
      CASH_OPERATIONS => "Cash operations",
      BALANCE_OPERATIONS => "Balance operations",
    }

    TABLE_NAMES = {
      CLOSED_POSITIONS => "closed_positions",
      OPEN_POSITIONS => "open_positions",
      PENDING_ORDERS => "pending_orders",
      CASH_OPERATIONS => "cash_operations",
      BALANCE_OPERATIONS => "balance_operations",
    }

    ID_NAMES = {
      OPEN_POSITIONS => "position",
      CLOSED_POSITIONS => "position",
      PENDING_ORDERS => "id2",
      CASH_OPERATIONS => "id2",
      BALANCE_OPERATIONS => "id2",
    }

    def self.get_id_name(table)
      raise ArgumentError, "Invalid table" unless ID_NAMES.key?(table)
      ID_NAMES[table]
    end

    def self.get_table_name(table)
      raise ArgumentError, "Invalid table" unless TABLE_NAMES.key?(table)
      TABLE_NAMES[table]
    end

    def self.get_description(table)
      raise ArgumentError, "Invalid table" unless DESCRIPTIONS.key?(table)
      DESCRIPTIONS[table]
    end

    def self.all_dtypes
      [CLOSED_POSITIONS, OPEN_POSITIONS, PENDING_ORDERS, CASH_OPERATIONS, BALANCE_OPERATIONS]
    end

    def self.valid?(dtype)
      all_dtypes.include?(dtype)
    end
  end
end
