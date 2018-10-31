
module SlidingPiece 
  #in moves check that no impeding piece 
  def moves
    debugger
    valid_moves = []
    move_dirs.each do |direction|
      direction.each do |pos|
        break if @board[pos].color == @color
        valid_moves << pos
      end
    end
    valid_moves
  end
  
  def horizontal_dirs
    left = generate_horizontal_direction(1, -1)
    right = generate_horizontal_direction(1, 1)
    up = generate_horizontal_direction(0, -1)
    down = generate_horizontal_direction(0, 1)
    [left] + [right] + [up] + [down]
  end
  
  def diagonal_dirs
    up_right = generate_diagonal_direction(-1, 1)
    up_left = generate_diagonal_direction(-1, -1)
    down_right = generate_diagonal_direction(1, 1)
    down_left = generate_diagonal_direction(1, -1)
    [up_right] + [up_left] + [down_right] + [down_left]
  end
  
  def generate_diagonal_direction(y_increment, x_increment)
    result = []
    current_pos = self.pos.dup
    while @board.valid_pos?(current_pos)
      current_pos[0] += y_increment
      current_pos[1] += x_increment
      result << current_pos
    end
    result
  end
  
  #axis: 0 or 1, increment: 1 or -1
  def generate_horizontal_direction(axis, increment)
    result = []
    current_pos = self.pos.dup
    while @board.valid_pos?(current_pos)
      current_pos[axis] += increment
      result << current_pos
    end
    result
  end
  
  
end