module TicTacToe
  class Game
    include TicTacToe::Rules

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

          check_move { |error_message| puts error_message }
          check_win  { puts "#{current_player} wins" }
          check_draw { puts "It's a tie" }
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
