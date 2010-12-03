module TicTacToe
  module Rules
    def check_move
      row, col = move_input
      board[row, col] = current_player
    rescue TicTacToe::Board::InvalidRequest => error
      yield error.message if block_given?
      retry
    end

    def check_win
      return false unless board.last_move

      win = board.intersecting_lines(*board.last_move).any? do |line|
        line.all? { |cell| cell == current_player }
      end

      if win
        yield
        game_over
      end
    end

    def check_draw
      if @board.covered?
        yield
        game_over
      end
    end
  end
end
