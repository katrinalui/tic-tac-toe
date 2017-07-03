class ComputerPlayer
  attr_reader :name
  attr_accessor :mark
  attr_reader :board

  def initialize(name)
    @name = name
    @mark = :O
  end

  def display(board)
    @board = board
  end

  def get_move
    board.grid.each_with_index do |row, i|
      return [i, nil_index(row)] if winning?(row)
    end

    board.grid.transpose.each_with_index do |col, i|
      return [nil_index(col), i] if winning?(col)
    end

    left_diagonal_arr = []
    0.upto(board.grid.length - 1) do |i|
      left_diagonal_arr << board[[i, i]]
    end
    if winning?(left_diagonal_arr)
      return [nil_index(left_diagonal_arr), nil_index(left_diagonal_arr)]
    end

    right_diagonal_arr = []
    0.upto(board.grid.length - 1) do |i|
      right_diagonal_arr << board.grid.map(&:reverse)[i][i]
    end
    if winning?(right_diagonal_arr)
      return [nil_index(right_diagonal_arr), nil_index(right_diagonal_arr)]
    end

    random_move
  end

  private

  def winning?(array)
    array.count(mark) == 2 && array.include?(nil)
  end

  def nil_index(array)
    array.index(nil)
  end

  def random_move
    empty_tiles = []

    board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        empty_tiles << [row_idx, col_idx] if tile.nil?
      end
    end

    empty_tiles.sample
  end
end
