require './magic_trick/magic_trick'

describe MagicTrick do
  let(:solver) {MagicTrick.new}

  describe '#solve' do
    it 'should return the number if only one overlapping' do
      input = {
        :guess1 => 2,
        :guess2 => 3,
        :grid1 => [
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 16]
        ],
        :grid2 => [
          [1, 2, 5, 4],
          [3, 11, 6, 15],
          [9, 10, 7, 12],
          [13, 14, 8, 16]
        ]
      }

      solution = solver.solve(input)
      expect(solution[:card]).to eq(7)
    end

    it 'should return bad magician if more than one overlapping' do
      input = {
        :guess1 => 2,
        :guess2 => 3,
        :grid1 => [
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 16]
        ],
        :grid2 => [
          [1, 2, 5, 4],
          [3, 11, 6, 15],
          [9, 6, 7, 12],
          [13, 14, 8, 16]
        ]
      }

      solution = solver.solve(input)
      expect(solution[:bad_magician]).to eq(true)
    end

    it 'should return cheated if none overlapping' do
      input = {
        :guess1 => 2,
        :guess2 => 3,
        :grid1 => [
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 16]
        ],
        :grid2 => [
          [1, 2, 5, 4],
          [3, 11, 6, 15],
          [9, 66, 77, 12],
          [13, 14, 8, 16]
        ]
      }

      solution = solver.solve(input)
      expect(solution[:cheated]).to eq(true)
    end
  end

  describe '#parse' do
    let(:input_file) {"magic_trick/sample.in"}
    it 'should return object with 2 guesses and 2 grids' do
      File.open(input_file, 'r') do |input|
        input.readline
        result = solver.parse(input)
        expect(result[:guess1]).to eq(2)
        expect(result[:grid1]).to eq([
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 16]
          ])
        expect(result[:guess2]).to eq(3)
        expect(result[:grid2]).to eq([
          [1, 2, 5, 4],
          [3, 11, 6, 15],
          [9, 10, 7, 12],
          [13, 14, 8, 16]
          ])
      end
    end
  end

  describe '#dump' do
    before(:each) do
      @output = StringIO.new
    end

    it 'should write number if result has one' do
      @output.should_receive(:write).with(7)
      solver.dump(@output, {:card => 7})
    end

    it 'should write bad magician when fail' do
      @output.should_receive(:write).with('Bad magician!')
      solver.dump(@output, {:bad_magician => true})
    end

    it 'should write cheater if cheated' do
      @output.should_receive(:write).with('Volunteer cheated!')
      solver.dump(@output, {:cheated => true})
    end
  end
end
