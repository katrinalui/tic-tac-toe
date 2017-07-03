require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :board
  attr_reader :player_one
  attr_reader :player_two
  attr_reader :current_player

  def initialize(player_one, player_two)
    @board = Board.new
    @player_one = player_one
    @player_two = player_two
    @current_player = player_one
  end

  def play
    play_turn until board.over?
    puts "Game over! The winner is #{board.winner}."
  end

  def play_turn
    current_player.display(board)
    move = nil
    while move.nil?
      move = current_player.get_move
      if board.empty?(move)
        board.place_mark(move, current_player.mark)
      else
        puts "Tile is already taken."
        move = nil
      end
    end
    switch_players! unless board.over?
  end

  def switch_players!
    if current_player == player_one
      @current_player = player_two
    else
      @current_player = player_one
    end
  end
end

if $0 == __FILE__
  print "Please enter your name: "
  player1 = HumanPlayer.new(gets.chomp)
  print "Please enter a name for your opponent: "
  player2 = ComputerPlayer.new(gets.chomp)
  game = Game.new(player1, player2)
  game.play
end
