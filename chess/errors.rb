class NullPieceError < StandardError
  def message
    "there is no piece, this is an invalid move"
  end
end

# class InvalidPosError < StandardError
#   def message
#     "this is not a space on the board"
#   end
# end

class InvalidTakeError < StandardError
  def message
    "you can't take your own piece"
  end
end

class InCheckError < StandardError
  def message
    "you must move out of check"
  end
end

class InvalidMoveError < StandardError
  def message
    "that is an invalid move"
  end
end