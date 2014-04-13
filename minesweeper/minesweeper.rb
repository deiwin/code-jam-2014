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
    return false
  end

  def breadth_first_traverse(input)
    queue = Queue.new
    queue << [input[:row], input[:column]]
    matrix = init_matrix_with_starting_loc(input)

    goal = input[:rows] * input[:columns] - input[:mines]
    marked = 1
    until queue.empty? || marked == goal do
      loc = queue.pop
      new_touching_locs = get_new_touching_locs(matrix, loc, input)
      p new_touching_locs
      next if marked + new_touching_locs.size > goal
      marked += new_touching_locs.size
      mark_locations(matrix, new_touching_locs, '.')
      new_touching_locs.each do |loc|
        queue << loc
      end
    end

    marked == goal ? matrix : false
  end

  def init_matrix_with_starting_loc(input)
    matrix = []
    input[:rows].times do
      row = []
      input[:columns].times do
        row << '*'
      end
      matrix << row
    end
    matrix[input[:row]][input[:column]] = 'c'
    return matrix
  end

  def mark_locations(matrix, locations, mark)
    locations.each do |loc|
      matrix[loc[0]][loc[1]] = mark
    end
  end

  def get_new_touching_locs(matrix, loc, input)
    get_touching_locs(loc, input).select do |loc|
      matrix[loc[0]][loc[1]] == '*'
    end
  end

  def get_touching_locs(loc, input)
    result = []
    max_row = input[:rows] - 1
    max_col = input[:columns] - 1
    result << [loc[0] + 1, loc[1] + 1] if loc[0] < max_row && loc[1] < max_col
    result << [loc[0],     loc[1] + 1] if                     loc[1] < max_col
    result << [loc[0] - 1, loc[1] + 1] if loc[0] > 0       && loc[1] < max_col
    result << [loc[0] + 1, loc[1]]     if loc[0] < max_row
    result << [loc[0] - 1, loc[1]]     if loc[0] > 0
    result << [loc[0] + 1, loc[1] - 1] if loc[0] < max_row && loc[1] > 0
    result << [loc[0],     loc[1] - 1] if                     loc[1] > 0
    result << [loc[0] - 1, loc[1] - 1] if loc[0] > 0       && loc[1] > 0
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
