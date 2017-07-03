class Board
  attr_reader :grid

  def initialize(grid = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]])
    @grid = grid
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    grid[row][col] = mark
  end

  def place_mark(pos, mark)
    self[pos] = mark
  end

  def empty?(pos)
    self[pos].nil?
  end

  def over?
    return true if winner
    false
  end

  def winner
    return :X if winner?(:X)
    return :O if winner?(:O)
    return "no one" if grid.none? { |row| row.include?(nil) }
  end

  private

  def won_row?(mark)
    0.upto(grid.length - 1) do |i|
      return true if grid[i].all? { |tile| tile == mark }
    end
    false
  end

  def won_col?(mark)
    0.upto(grid.length - 1) do |i|
      return true if grid.transpose[i].all? { |tile| tile == mark }
    end
    false
  end

  def won_diag?(mark)
    diagonal_arr = []
    0.upto(grid.length - 1) do |i|
      diagonal_arr << self[[i, i]]
    end
    return true if diagonal_arr.all? { |tile| tile == mark }
    diagonal_arr = []
    0.upto(grid.length - 1) do |i|
      diagonal_arr << grid.map(&:reverse)[i][i]
    end
    return true if diagonal_arr.all? { |tile| tile == mark }
    false
  end

  def winner?(mark)
    return true if won_row?(mark) || won_col?(mark) || won_diag?(mark)
    false
  end
end
