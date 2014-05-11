require './solver'

class PartElf
  include Solver

  def solve(input)
    ancestors, elf_ancestors = to_lowest_terms(input[:ancestors], input[:elf_ancestors])
    i = 1
    nth_generation = 0
    while i < elf_ancestors do
      i*=2
      nth_generation += 1
    end
    nth_generation -=1 if i > elf_ancestors
    begin
      total_generations = as_nth_power_of_2(ancestors)
    rescue
      return nil
    end
    total_generations - nth_generation
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

  def as_nth_power_of_2(number)
    i = 0
    while number > 1 do
      throw :not_a_power_of_2 if number % 2 > 0
      number /= 2
      i += 1
    end
    i
  end

  def power_of_2_larger_or_equal_than(number)
    i = 1
    while i < number do
      i*=2
    end
    i
  end

  def to_lowest_terms(a, b)
    while (d = a.gcd(b)) > 1 do
      a /= d
      b /= d
    end
    return a, b
  end

end
