require_relative "piece"
require_relative "errors"
require "byebug"

class Board
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    fill_board
  end
  
  def fill_board
    grid.each_with_index do |row, row_idx|
      if row == 1
        row.each_with_index do |ele, col_idx|
          self[[row_idx, col_idx]] = Pawn.new(self, [row_idx, col_idx], :white)
        end
      elsif row == 6
        row.each_with_index do |ele, col_idx|
          self[[row_idx, col_idx]] = Pawn.new(self, [row_idx, col_idx], :black)
        end
      elsif row_idx.between?(2, 5)
        row.each_with_index do |ele, col_idx|
          self[[row_idx, col_idx]] = NullPiece.instance
        end
      elsif row == 0
        color = :white
        row.each_with_index do |ele, col_idx|
          self[[row_idx, col_idx]] = Rook.new(self, [row_idx, col_idx], color) if col_idx == 0 || col_idx == 7
          self[[row_idx, col_idx]] = Knight.new(self, [row_idx, col_idx], color) if col_idx == 1 || col_idx == 6
          self[[row_idx, col_idx]] = Bishop.new(self, [row_idx, col_idx], color) if col_idx == 2 || col_idx == 5
          self[[row_idx, col_idx]] = Queen.new(self, [row_idx, col_idx], color) if col_idx == 3
          self[[row_idx, col_idx]] = King.new(self, [row_idx, col_idx], color) if col_idx == 4
        end
      else
        color = :black
        row.each_with_index do |ele, col_idx|
          self[[row_idx, col_idx]] = Rook.new(self, [row_idx, col_idx], color) if col_idx == 0 || col_idx == 7
          self[[row_idx, col_idx]] = Knight.new(self, [row_idx, col_idx], color) if col_idx == 1 || col_idx == 6
          self[[row_idx, col_idx]] = Bishop.new(self, [row_idx, col_idx], color) if col_idx == 2 || col_idx == 5
          self[[row_idx, col_idx]] = Queen.new(self, [row_idx, col_idx], color) if col_idx == 3
          self[[row_idx, col_idx]] = King.new(self, [row_idx, col_idx], color) if col_idx == 4
        end
      end
    end
    
  end
  
  def in_check?(color)
    king_pos = [0,0]
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |ele, col_idx|
        if ele.is_a?(King) && ele.color == color
          king_pos = [row_idx, col_idx]
        end
      end
    end
    
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |ele, col_idx|
        unless ele.is_a?(NullPiece) && ele.color == color && ele.is_a?(King)
          return true if ele.moves.include?(king_pos)
        end
      end
    end
    false
  end
  
  def checkmate?(color)
    king_pos = [0,0]
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |ele, col_idx|
        if ele.is_a?(King) && ele.color == color
          if in_check?(color) && ele.moves.empty?
            return true 
          else
            return false
          end
        end
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
    
    raise NullPieceError if piece.is_a?(NullPiece)
    # debugger
    possible_moves = piece.moves
    
    raise InvalidMoveError unless possible_moves.include?(end_pos)
    
    end_piece = self[end_pos]
    
    #checking if we are taking our own piece
    raise InvalidTakeError if end_piece.color == piece.color
    
    raise InCheckError if piece.move_into_check?(end_pos)
    
    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
  end
  
  def inspect
    @grid
  end
  
  def valid_pos?(pos)
    if pos.first.between?(0, 7) && pos.last.between?(0, 7)
      return true
    else
      return false
    end
    
  end
  
  def dup
    new_board = Board.new
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |ele, col_idx|
        new_board[[row_idx, col_idx]] = ele.dup
        new_board[[row_idx, col_idx]].pos = ele.pos.dup
      end
    end
    new_board
  end
  
  
  
end




