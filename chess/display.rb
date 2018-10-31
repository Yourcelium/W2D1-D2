require_relative 'board'
require_relative 'cursor'
require 'colorize'
require "byebug"

class Display
  attr_reader :board
  def initialize
    @board = Board.new()
    @cursor = Cursor.new([0,0], board)  
  end
  
  def render
    # until board.valid_pos?
    # @cursor.cursor_pos.red
    @board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |ele, col_idx|
        if [row_idx, col_idx] == @cursor.cursor_pos
          print (" " + ele.inspect + " ").colorize(background: :red)
        else
          print (" " + ele.inspect + " ")
        end
      end 
      puts
    end
  end
  
  def run
      10.times do 
        system "clear"
        self.render
        start_pos = @cursor.get_input
        # debugger
        if start_pos.is_a?(Array)
          end_pos = @cursor.get_input if end_pos.is_a?(Array)
          @board.move_piece(start_pos, end_pos)
        end
        
      end
  end
  
end

 
a = Display.new
a.run