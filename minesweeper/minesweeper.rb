require './solver'

class Minesweeper
  include Solver

  def solve(input)
    for row in 0..(input[:rows] - 1)
      for column in 0..(input[:columns] - 1)
        solution = depth_first_traverse(input.merge({
          :row => row,
          :column => column
          }))
        return solution if solution
      end
    end
    return false
  end

  def depth_first_traverse(input)
    matrix = init_matrix_with_starting_loc(input)
    goal = input[:rows] * input[:columns] - input[:mines]
    marked = 1
    loc = [input[:row], input[:column]]
    return traverse(loc, matrix, marked, goal, input)
  end

  def traverse(loc, matrix, marked, goal, input)
    new_touching_locs = get_new_touching_locs(matrix, loc, input)
    new_marked = marked + new_touching_locs.size
    return false if new_marked > goal
    new_matrix = mark_locations(matrix, new_touching_locs, '.')
    return new_matrix if new_marked == goal
    new_touching_locs.each do |loc|
      result = traverse(loc, new_matrix, new_marked, goal, input)
      return result if result
    end
    return false
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
    result = Marshal.load( Marshal.dump( matrix ) )
    locations.each do |loc|
      result[loc[0]][loc[1]] = mark
    end
    return result
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
    result << [loc[0] - 1, loc[1] - 1] if loc[0] > 0       && loc[1] > 0
    result << [loc[0],     loc[1] - 1] if                     loc[1] > 0
    result << [loc[0] + 1, loc[1] - 1] if loc[0] < max_row && loc[1] > 0
    result << [loc[0] - 1, loc[1]]     if loc[0] > 0
    result << [loc[0] + 1, loc[1]]     if loc[0] < max_row
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
