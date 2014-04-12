module Solver
  def solve_with_file (in_file)
    File.open(in_file, 'r') do |input|
      File.open(in_file.sub(/\.in/, '.out'), 'w') do |output|
        cases = input.readline.to_i
        1.upto(cases).each do |case_nr|
          output.write("Case ##{case_nr}: ")
          test_data = parse(input)
          solution = solve(test_data)
          dump(output, solution)
          output.write("\n") if case_nr != cases
        end
      end
    end
  end
end
