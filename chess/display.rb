require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
  attr_reader :board
  def initialize
    @board = Board.new()
    @cursor = Cursor.new([0,0], board)  
  end
  
  def render
    # until board.valid_pos?
    # @cursor.cursor_pos.red
    @board.grid.each do |row|
      row.each do |ele|
        print ele.inspect + " "
      end 
      puts
    end
    
  end
  
end


a = Display.new
a.render