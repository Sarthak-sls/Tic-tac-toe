class Game
  @@turn_count = 1
  @@winner = " "

  def initialize
    puts "Player 1!Please put your name"
    @Player_one_name = gets.chomp
    puts "Player 2!Please put your name"
    @Player_two_name = gets.chomp
    @board = Array.new(3) { Array.new(3, "_") }
  end

  # blank board
  def display_board(board)
    puts "#{board[0][0]} | #{board[0][1]} | #{board[0][2]}"
    puts "#{board[1][0]} | #{board[1][1]} | #{board[1][2]}"
    puts "#{board[2][0]} | #{board[2][1]} | #{board[2][2]}"
  end

  def player_turn(turn)
    if turn.odd?
      player_choice(@Player_one_name, "x")
    else
      player_choice(@Player_two_name, "o")
    end
  end

  def player_choice(player, symbol)
    puts "#{player} please enter your coordinates"
    input = gets.chomp
    input_array = input.split
    coord_one = input_array[0].to_i
    coord_two = input_array[1].to_i

    until input.match(/\s/) && coord_one.between?(0,
                                                  2) && coord_two.between?(0, 2) && @board[coord_one][coord_two] == "_"
      puts "please enter a valid coordinate separated by a space"
      input = gets.chomp
      input_array = input.split
      coord_one = input_array[0].to_i
      coord_two = input_array[1].to_i
    end

    add_to_board(coord_one, coord_two, symbol)
  end

  def add_to_board(coord_one, coord_two, symbol)
    @board[coord_one][coord_two] = symbol
    @@turn_count += 1
  end

  def three_across
    @board.each do |i|
      if i.all? { |j| j == "x" }
        @@winner = "x"
        @@turn_count = 10
      elsif i.all? { |j| j == "o" }
        @@winner = "o"
        @@turn_count = 10
      end
    end
  end


  def three_down
    flat = @board.flatten
    flat.each_with_index do |v, i|
      if v == 'x' && flat[i + 3] == 'x' && flat[i + 6] == 'x'
        @@winner = 'x'
        @@turn_count = 10
      elsif v == 'o' && flat[i + 3] == 'o' && flat[i + 6] == 'o'
        @@winner = 'o'
        @@turn_count = 10
      else
        nil
      end
    end
  end

  def three_diagonal
    center_val = @board[1][1]
    if center_val == 'x' || center_val == 'o'
      if @board[0][0] && @board[2][2] == center_val
        @@winner = center_val
        @@turn_count = 10
      elsif @board[2][0] && @board[0][2] == center_val
        @@winner = center_val
        @@turn_count = 10
      end
    else
      nil
    end
  end

  def declare_result(symbol)
    case symbol
    when 'x'
      puts "#{@Player_one_name} wins the game!"
    when 'o'
      puts "#{@Player_two_name} wins the game!"
    else
      puts "It's a tie!"
    end
  end
   
  def play_game
    display_board(@board)
    

    until @@turn_count >= 10 do
      player_turn(@@turn_count)
      three_across
      three_down
       three_diagonal
      display_board(@board)
    end

    declare_result(@@winner)
  end 

end


game=Game.new
game.play_game