require './solver'

describe Solver do
  let(:solver) { Class.new { extend Solver } }

  describe '#solve_with_file' do
    it 'should call solve' do
      solver.should_receive(:solve)
      solver.solve_with_file
    end
  end
end
