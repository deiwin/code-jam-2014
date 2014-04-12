module Solver
  def solve_with_file (in_file)
    File.open(in_file, 'r') do |input|
      #File.open(in_file.sub(/\.in/, '.out'), 'w') do |output|
      cases = input.readline.to_i
      cases.times do
        test_data = parse(input)
        solve(test_data)
      end
      #end
    end
  end
end
