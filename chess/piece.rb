require "singleton"
require_relative "board"
require "byebug"
require_relative 'sliding_piece'
require_relative 'stepping_piece'

class Piece
  # debugger
  attr_reader :pos, :color, :board
  def initialize(board, pos, color)
    # debugger
    @color = color
    @pos = pos
    @board = board
  endß
  
  def move_into_check?(end_pos)
    board_copy = @board.dup
    current_pos = self.pos
    piece_copy = board_copy[current_pos]
    piece_copy.pos = end_pos
    board_copy[current_pos] = NullPiece.instance
    board_copy[end_pos] = piece_copy
    board_copy.in_check?(piece_copy.color)
  end
end

class Pawn < Piece
  
  def inspect
    "X"
  end
  
  def moves
    result = []
    up_moves, take_moves = get_pawn_moves
    take_moves.each do |space|
      if !@board[space].is_a?(NullPiece) && @board[space].color != self.color
        result << space
      end
    end
    up_moves.each do |space|
      result << space if @board[space].is_a?(NullPiece)
    end
    result
  end
  
  def get_pawn_moves
    result = []
    if @color == :white
      if @pos.first == 1
        #starting position logic
        row, col = @pos
        possible_up_moves = [[row - 1, col], [row - 2, col]]
        possible_diagonal_moves = [[row - 1, col + 1], [row - 1, col - 1]]
        result << possible_up_moves
        result << possible_diagonal_moves
      else
        row, col = @pos
        possible_up_moves = [[row - 1, col]]
        possible_diagonal_moves = [[row - 1, col + 1], [row - 1, col - 1]]
        result << possible_up_moves
        result << possible_diagonal_moves
      end
    else #logic if @color == :black
      if @pos.first == 1
        #starting position logic
        row, col = @pos
        possible_up_moves = [[row + 1, col], [row + 2, col]]
        possible_diagonal_moves = [[row + 1, col + 1], [row + 1, col - 1]]
        result << possible_up_moves
        result << possible_diagonal_moves
      else
        row, col = @pos
        possible_up_moves = [[row + 1, col]]
        possible_diagonal_moves = [[row + 1, col + 1], [row + 1, col - 1]]
        result << possible_up_moves
        result << possible_diagonal_moves
      end
    end
    result
  end
end

class King < Piece
  include SteppingPiece
  
  def inspect
    if @color == :white
      "\u{2656}"
    else
      "\u{265C}"
    end
  end
  
  def move_dirs
    king_dirs
  end
end

class Knight < Piece
  include SteppingPiece
  
  def inspect
    if @color == :white
      "\u{2656}"
    else
      "\u{265C}"
    end
  end
  
  def move_dirs
    knight_dirs
  end
end


class Bishop < Piece
  include SlidingPiece
  
  def inspect
    if @color == :white
      "\u{2657}"
    else
      "\u{265D}"
    end
  end
  
  def move_dirs
    diagonal_dirs
  end
  
  
end

class Rook < Piece
  include SlidingPiece
  
  def inspect
    if @color == :white
      "\u{2656}"
    else
      "\u{265C}"
    end
  end
  
  def move_dirs
    horizontal_dirs
  end
end

class Queen < Piece
  include SlidingPiece
  
  def inspect
    if @color == :white
      "\u{2655}"
    else
      "\u{265B}"
    end
  end
  
  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end


class NullPiece < Piece
  include Singleton
  
  def initialize
    @color = :transparent
  end

  def inspect
    "-"
  end
  
end

