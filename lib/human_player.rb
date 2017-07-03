class HumanPlayer
  attr_reader :name
  attr_accessor :mark

  def initialize(name)
    @name = name
    @mark = :X
  end

  def get_move
    print "Please enter where you would like to place a mark (e.g. 0, 0): "
    input = gets.chomp
    input.split(", ").map(&:to_i)
  end

  def display(board)
    row_1 = display_row(board, 0)
    row_2 = display_row(board, 1)
    row_3 = display_row(board, 2)
    puts " #{row_1} \n-----------\n #{row_2} \n-----------\n #{row_3} "
  end

  private

  def display_row(board, index)
    row = board.grid[index].map do |el|
      if el.nil?
        " "
      else
        el.to_s
      end
    end
    row.join(" | ")
  end
end
