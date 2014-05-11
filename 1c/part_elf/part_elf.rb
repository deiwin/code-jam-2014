require './solver'

class PartElf
  include Solver

  def solve(input)

  end

  def dump(output, solution)
    if (solution)
      output.write(solution)
    else
      output.write("impossible")
    end
  end

  def parse(input)
    inputs = input.readline.split(/\//).map { |s| s.to_i }
    [:elf_ancestors, :ancestors].zip(inputs).to_h
  end

end
