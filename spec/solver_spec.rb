require './solver'

describe Solver do
  let(:solver) { Class.new { extend Solver } }

  describe '#solve_with_file' do
    let(:filename) { 'filename.in' }
    before(:each) do
      solver.stub(:solve)
      solver.stub(:parse)
    end

    context 'with 1 case' do
      before(:each) do
        File.stub(:open).with(filename,'r').and_yield(StringIO.new("1\nb"))
      end

      it 'should call solve' do
        solver.should_receive(:solve)
        solver.solve_with_file(filename)
      end

      it 'should open file' do
        File.should_receive(:open).with(filename, 'r')
        solver.solve_with_file(filename)
      end
    end

    context 'with 2 cases' do
      let(:input) { "2\ncase1\ncase2" }
      before(:each) do
        File.stub(:open).with(filename,'r').and_yield(StringIO.new(input))
      end

      it 'should call parse for each case' do
        solver.should_receive(:parse).twice
        solver.solve_with_file(filename)
      end

      context 'with readline parser' do
        before(:each) do
          solver.stub(:parse) do |input|
            input.readline.sub(/\n/, '')
          end
        end

        it 'should call solver with lines read from input' do
          solver.should_receive(:solve).with('case1')
          solver.should_receive(:solve).with('case2')
          solver.solve_with_file(filename)
        end
      end
    end
  end
end
