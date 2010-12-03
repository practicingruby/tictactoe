module TicTacToe
  class Game
    def initialize
      @board   = TicTacToe::Board.new
      @players = [:X, :O].cycle
    end

    attr_reader :board, :players, :current_player

    def play
      catch(:finished) do
        loop do
          start_new_turn 
          show_board
          move

          check_for_win
          check_for_draw
        end
      end
    end

    def start_new_turn
      @current_player = @players.next
    end

    def show_board
      puts board
    end

    def game_over
      throw :finished
    end

    def move
      row, col = move_input
      board[row, col] = current_player
    rescue TicTacToe::Board::InvalidRequest => error
      puts error.message
      retry
    end

    def check_for_win
      return false unless board.last_move

      win = board.intersecting_lines(*board.last_move).any? do |line|
        line.all? { |cell| cell == current_player }
      end

      if win
        puts "#{current_player} wins!"
        game_over
      end
    end

    def check_for_draw
      if @board.covered?
        puts "It's a tie!"
        game_over
      end
    end

    def move_input
      print "\n>> "
      response = gets
      
      case response
      when /quit/i
        puts "Wimp!"
        throw :finished
      else
        row, col = response.chomp.split.map { |e| e.to_i }
        puts

        [row, col]
      end
    end
  end
end
