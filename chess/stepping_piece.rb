module SteppingPiece
  def moves
    
  end
  
  def knight_dirs
    current_pos = self.pos.dup
    result = []
    (-2..2).each do |row|
      (-2..2).each do |col|
        unless row == 0 || col == 0 || row.abs == col.abs
          pos_row = current_pos[0] + row
          pos_col = current_pos[1] + col
          result << [pos_row, pos_col]
        end
      end
    end
    result
  end
  
  def king_dirs
    current_pos = self.pos.dup
    result = []
    (-1..1).each do |row|
      (-1..1).each do |col|
        unless row == 0 && col == 0
          pos_row = current_pos[0] + row
          pos_col = current_pos[1] + col
          result << [pos_row, pos_col]
        end
      end
    end
    result
  end
  
end