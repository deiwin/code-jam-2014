require './solver'

describe Solver do
  let(:solver) { Class.new{ include Solver }.new }

  describe '#solve_with_file' do
    let(:filename) { 'filename.in' }
    let(:out_filename) { 'filename.out' }
    before(:each) do
      solver.stub(:solve)
      solver.stub(:parse)
      solver.stub(:dump)
    end

    context 'with 1 case' do
      before(:each) do
        allow(File).to receive(:open).with(filename,'r').and_yield(StringIO.new("1\nb"))
        allow(File).to receive(:open).with(out_filename,'w').and_yield(StringIO.new)
      end

      it 'should call solve' do
        solver.should_receive(:solve)
        solver.solve_with_file(filename)
      end

      it 'should open input file' do
        File.should_receive(:open).with(filename, 'r')
        solver.solve_with_file(filename)
      end

      it 'should open ouput file' do
        File.should_receive(:open).with(out_filename, 'w')
        solver.solve_with_file(filename)
      end
    end

    context 'with 2 cases' do
      let(:input) { "2\ncase1\ncase2" }
      before(:each) do
        @ouput = StringIO.new
        allow(File).to receive(:open).with(filename,'r').and_yield(StringIO.new(input))
        allow(File).to receive(:open).with(out_filename,'w').and_yield(@ouput)
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

      context 'dummy solver responses' do
        before(:each) do
          allow(solver).to receive(:solve).and_return('solution1', 'solution2')
        end

        it 'should call dump with ouput and solutions from solver' do
          solver.should_receive(:dump).with(@ouput, 'solution1')
          solver.should_receive(:dump).with(@ouput, 'solution2')
          solver.solve_with_file(filename)
        end
      end

      context 'dummy dump implementation' do
        before(:each) do
          allow(solver).to receive(:solve).and_return('solution1', 'solution2')
          allow(solver).to receive(:dump) do |output, solution|
            output.write(solution)
          end
        end

        it 'write results to output file' do
          solver.solve_with_file(filename)
          expect(@ouput.string).to eq("Case #1: solution1\nCase #2: solution2")
        end
      end
    end
  end
end
