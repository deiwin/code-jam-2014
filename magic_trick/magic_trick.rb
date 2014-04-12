require './solver'

class MagicTrick
  include Solver

  def solve(input)
    row1 = input[:grid1][input[:guess1] - 1]
    row2 = input[:grid2][input[:guess2] - 1]
    overlap = (row1 & row2)
    return {:card => overlap[0]} if overlap.size == 1
    return {:cheated => true} if overlap.empty?
    return {:bad_magician => true}
  end

  def dump(output, solution)
    output.write(solution[:card]) if solution[:card]
    output.write('Bad magician!') if solution[:bad_magician]
    output.write('Volunteer cheated!') if solution[:cheated]
  end

  def parse(input)
    result = {}
    result[:guess1] = input.readline.to_i
    result[:grid1] = parse_grid(input)
    result[:guess2] = input.readline.to_i
    result[:grid2] = parse_grid(input)
    return result
  end

  def parse_grid(input)
    result = []
    4.times do
      result << input.readline.split(/ /).map { |s| s.to_i }
    end
    return result
  end
end
