require './solver'

class Minesweeper
  include Solver

  def solve(input)
    for row in 0..(input[:rows] - 1)
      for column in 0..(input[:columns] - 1)
        solution = breadth_first_traverse(input.merge({
          :row => row,
          :column => column
          }))
        return solution if solution
      end
    end
  end

  def breadth_first_traverse(input)
    queue = Queue.new
    queue << [input[:row], input[:column]]
    matrix = Array.new(input[:rows], Array.new(input[:columns], '*'))
    matrix[input[:row], input[:column]] = 'c'

    goal = input[:row] * input[:column] - input[:mines]

    until queue.empty? do
      loc = queue.pop
      touching_locs = get_touching_locs(loc, input)
    end

    matrix
  end

  def get_touching_locs(loc, input)
    result = []
    max_row = input[:rows] - 1
    max_col = input[:columns] - 1
    result << [loc[0] - 1, loc[1] - 1] if loc[0] > 0       && loc[1] > 0
    result << [loc[0],     loc[1] - 1] if                     loc[1] > 0
    result << [loc[0] + 1, loc[1] - 1] if loc[0] < max_row && loc[1] > 0
    result << [loc[0] - 1, loc[1]]     if loc[0] > 0       && loc[1] > 0
    result << [loc[0] + 1, loc[1]]     if loc[0] < max_row && loc[1] > 0
    result << [loc[0] - 1, loc[1] + 1] if loc[0] > 0       && loc[1] < max_col
    result << [loc[0],     loc[1] + 1] if                     loc[1] < max_col
    result << [loc[0] + 1, loc[1] + 1] if loc[0] < max_row && loc[1] < max_col
    return result
  end

  def parse(input)
    inputs = input.readline.split(/ /).map { |s| s.to_i }
    [:rows, :columns, :mines].zip(inputs).to_h
  end

  def dump(output, solution)
    output.write("\n")
    if solution
      solution.each_with_index do |row, index|
        output.write(row.join)
        output.write("\n") if index < solution.size - 1
      end
    else
      output.write('Impossible')
    end
  end
end
