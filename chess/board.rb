require_relative "piece"

class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    grid.each_with_index do |row, idx|
      if idx < 2 || idx > 5
        row.map! { |space| space = Piece.new }
      else
        row.map! { |space| space = NullPiece.new }
      end
    end
  end
  
  def [](pos)
    rows, cols = pos
    @grid[rows][cols]
  end
  
  def []= (pos, piece)
    rows, cols = pos
    @grid[rows][cols] = piece
  end
  
  def move_piece(start_pos, end_pos) 
    piece = self[start_pos]   
    if piece.is_a?(NullPiece) 
      raise NullPieceError
    end
    
    unless end_pos.first.between?(0, 7) && end_pos.last.between?(0, 7)
      raise InvalidPosError
    end
    self[end_pos] = piece
    self[start_pos] = NullPiece.new()
  end
  
  def inspect
    @grid
  end
  
  def valid_pos?
    
  end
  
end

class NullPieceError < StandardError
  def message
    "there is no piece, this is an invalid move"
  end
end


class InvalidPosError < StandardError
  def message
    "this is not a space on the board"
  end
end



