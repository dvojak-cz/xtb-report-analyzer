require "active_record"
require_relative "ui/menu"
require_relative "ui/body"
require_relative "data/data_analyzer"
require_relative "ui/convertor"

class UI
  # constructor

  COMMANDS = {
    'h': "Help",
    'q': "Quit",
    'o': "Open position",
    'c': "Close position",
    'p': "Pending orders",
    'e': "Chart",
  }

  def initialize(db_path)
    raise ArgumentError, "db_path must be a non-empty string" unless db_path.is_a?(String) && !db_path.empty?
    raise ArgumentError, "db_path must be a valid path to a readable file" unless File.exist?(db_path) && File.readable?(db_path)

    begin
      ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: db_path)
    rescue StandardError => e
      raise ArgumentError, "Error establishing connection to database: #{e.message}"
    end

    @db_path = db_path
    @menu = UUI::Menu.new("Stocks", "1.0.0", COMMANDS, db_path)
    @body = UUI::Body.new(COMMANDS)
    @reader = TTY::Reader.new

    @data_analyzer = DataAnalyer.new
  end

  def run()
    loop do
      display
      case @reader.read_keypress.downcase
      when "h"
        @body.help
      when "q"
        clear_screen
        break
      when "o"
        @body.open_positions
      when "c"
        @body.close_position
      when "p"
        @body.pending_orders
      when "e"
        @body.etfs
      when "s"
      when "m"
      else
      end
    end
  end

  private

  def clear_screen = puts "\e[H\e[2J"

  def display()
    clear_screen
    puts @menu.generate
    puts @body.generate
  end
end