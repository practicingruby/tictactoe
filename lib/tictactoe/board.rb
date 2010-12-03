module TicTacToe
  class Board
    InvalidRequest = Class.new(StandardError)

    LEFT_DIAGONAL_POSITIONS  = [[0,0],[1,1],[2,2]]
    RIGHT_DIAGONAL_POSITIONS = [[2,0],[1,1],[0,2]]
    SPAN                     = (0..2)
    CELL_COUNT               = 9

    def initialize
      @data = [[nil,nil,nil],
               [nil,nil,nil],
               [nil,nil,nil]]

      @last_move = nil
    end

    attr_reader :last_move

    def [](row, col)
      @data.fetch(row).fetch(col)
    rescue IndexError
      raise InvalidRequest, "Position is not within the grid"
    end

    def []=(row, col, marker)
      if self[row, col]
        raise InvalidRequest, "Position is already occupied"
      end

      @data[row][col] = marker
      @last_move     = [row,col]
    end

    def to_s
      @data.map { |row| row.map { |e| e || " " }.join("|") }.join("\n")
    end

    def intersecting_lines(r1, c1)
      [left_diagonal, right_diagonal, row(r1), column(c1)]
    end

    def covered?
      @data.flatten.compact.length == CELL_COUNT
    end

    def left_diagonal
      LEFT_DIAGONAL_POSITIONS.map { |e| self[*e] }
    end

    def right_diagonal
      RIGHT_DIAGONAL_POSITIONS.map { |e| self[*e] }
    end

    def row(index)
      SPAN.map { |column| self[index, column] }
    end
    
    def column(index)
      SPAN.map { |row| self[row, index] }
    end
  end
end
