class Game
    @@round_count = 1
    @@winner = ''
    def initialize
        puts 'Player 1 - enter your name to play'
        @player_1_name = gets.chomp
        puts 'Player 2 - enter your name to play'
        @player_2_name = gets.chomp
        @board = Array.new(3) { Array.new(3, '_') }
    end
    # board showing the game board
    def disp_board(board)
        puts "\r"
        puts "   0   1   2"
        puts "0  #{board[0][0]} | #{board[0][1]} | #{board[0][2]}"
        puts "1  #{board[1][0]} | #{board[1][1]} | #{board[1][2]}"
        puts "2  #{board[2][0]} | #{board[2][1]} | #{board[2][2]}"
        puts "\r"
    end
    def player_move(turn)
        if turn.odd?
            player_choice(@player_1_name, 'O')
        else
            player_choice(@player_2_name, 'X')
        end
    end
    def player_choice(player, symbol)
        puts "#{player} please enter your coordinates"
        input = gets.chomp
        input_arr = input.split
        coord_one = input_arr[0].to_i
        coord_two = input_arr[1].to_i

        # loop until the user has input valid inputs (has space, between 
        # 0-2 and board cell is empty)
        until input.match(/\s/) && coord_one.between?(0, 2) && 
            coord_two.between?(0, 2) && @board[coord_one][coord_two] = '_'
            puts "Please enter valid coordinates of an empty cell. e.g. 0 2"
            input = gets.chomp
            input_arr = input.split
            coord_one = input_arr[0].to_i
            coord_two = input_arr[1].to_i
        end

        add_to_board(coord_one, coord_two, symbol)
    end
    def add_to_board(coord_one, coord_two, symbol)
        @board[coord_one][coord_two] = symbol
        @@round_count += 1
    end

    #check whether all cells in any row match either user input
    def three_horizontally

        @board.each do |i|
            # (1..4).all? {|element| element < 5 } 
            if i.all? {|element| element == 'X'}
                @@winner = 'X'
                @@round_count = 10
            elsif i.all? {|element| element == 'O'}
                @@winner = 'O'
                @@round_count = 10
            else
                nil
            end
        end
    end

    #check whether all cells in any column match either user input
    def three_vertically
        flatten_board = @board.flatten
        flatten_board.each_with_index do |val, index|
            if val == 'X' && flatten_board[index + 3] == 'X' && flatten_board[index + 6] == 'X'
                @@winner = 'X'
                @@round_count = 10            
            elsif val == 'O' && flatten_board[index + 3] == 'O' && flatten_board[index + 6] == 'O'
                @@winner = 'O'
                @@round_count = 10
            else
                nil
            end
        end
    end

    # check whether all cells diagonally match either user input
    def three_diagonaly
        center_val = @board[1][1]
        if center_val == 'X' || center_val == 'O'
            if @board[0][0] && @board[2][2] == center_val
                @@winner = center_val
                @@round_count = 10
            elsif @board[2][0] && @board[0][2] == center_val
                @@winner = center_val
                @@round_count = 10
            end
        else
            nil
        end
    end
    def declare_result(symbol)
        case symbol
        when 'O'
            puts "#{@player_1_name} wins"
        when 'X'
            puts "#{@player_2_name} wins"
        else
            puts "It's a tie"
        end
    end

    def play_game
        puts "\r\n"
        disp_board(@board)
        until @@round_count >= 10 do
            player_move(@@round_count)
            three_horizontally
            three_vertically
            three_diagonaly
            disp_board(@board)
        end
        declare_result(@@winner)
    end
end


#instructions
puts 'Welcome to tic-tac-toe. To play the game, enter two number 
with a space from 0 to 2 to indicated coordinates of your mark'



game = Game.new
game.play_game