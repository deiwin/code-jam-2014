require './solver'

class Lottery
  include Solver

  def solve(input)
    old_safe_numbers = [input[:old_less], input[:tickets_less]].min - 1
    new_safe_numbers = [input[:new_less], input[:tickets_less]].min - 1
    safe_tickets = old_safe_numbers * new_safe_numbers

    for i in input[:tickets_less]..(input[:old_less] - 1)
      for j in input[:tickets_less]..(input[:new_less] - 1)
        if ((i & j) < input[:tickets_less])
          safe_tickets += 1
        end
      end
    end

    safe_tickets
  end

  def dump(output, solution)
    output.write(solution)
  end

  def parse(input)
    inputs = input.readline.split(/ /).map { |s| s.to_i }
    [:old_less, :new_less, :tickets_less].zip(inputs).to_h
  end

end
