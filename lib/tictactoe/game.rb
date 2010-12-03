module TicTacToe
  class Game
    def initialize
      @board   = [[nil,nil,nil],
                  [nil,nil,nil],
                  [nil,nil,nil]]

      @players = [:X, :O].cycle
    end

    attr_reader :board, :players, :current_player

    def play
      start_new_turn

      loop do
        display_board

        row, col = move_input
        next unless valid_move?(row,col) 

        board[row][col] = current_player

        if winning_move?(row, col)
          puts "#{current_player} wins!"
          return
        end

        if draw? 
          puts "It's a draw!"
          return
        end

        start_new_turn 
      end
    end

    def start_new_turn
      @current_player = @players.next
    end

    def display_board
      puts board.map { |row| row.map { |e| e || " " }.join("|") }.join("\n")
    end

    def winning_move?(row, col)
      left_diagonal = [[0,0],[1,1],[2,2]]
      right_diagonal = [[2,0],[1,1],[0,2]]

      lines = []

      [left_diagonal, right_diagonal].each do |line|
        lines << line if line.include?([row,col])
      end

      lines << (0..2).map { |c1| [row, c1] }
      lines << (0..2).map { |r1| [r1, col] }

      lines.any? do |line|
        line.all? { |row,col| board[row][col] == current_player }
      end
    end

    def draw?
      board.flatten.compact.length == 9
    end

    def valid_move?(row,col)
      begin
        cell_contents = board.fetch(row).fetch(col)
      rescue IndexError
        puts "Out of bounds, try another position"
        return false
      end
      
      if cell_contents
        puts "Cell occupied, try another position"
        return false
      end

      true
    end

    def move_input
      print "\n>> "
      row, col = gets.split.map { |e| e.to_i }
      puts

      [row, col]
    end

  end
end
