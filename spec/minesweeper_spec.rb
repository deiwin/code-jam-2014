require './minesweeper/minesweeper'

describe Minesweeper do
  let(:solver) {Minesweeper.new}

  describe '#solve' do
    it 'should solve example 1' do
      input = {
        :rows => 5,
        :columns => 5,
        :mines => 23
      }
      solution = solver.solve(input)
      expect(solution).to eq(false)
    end

    it 'should solve example 2' do
      input = {
        :rows => 3,
        :columns => 1,
        :mines => 1
      }
      solution = solver.solve(input)
      expect(solution).to eq([['c'], ['.'], ['*']])
    end

    it 'should solve example 3' do
      input = {
        :rows => 2,
        :columns => 2,
        :mines => 1
      }
      solution = solver.solve(input)
      expect(solution).to eq(false)
    end

    it 'should solve example 4' do
      input = {
        :rows => 4,
        :columns => 7,
        :mines => 3
      }
      solution = solver.solve(input)
      expect(solution).to eq([
        ['c', '.', '.', '.', '.', '.', '.' ],
        ['.', '.', '.', '.', '.', '.', '.' ],
        ['.', '.', '.', '.', '.', '.', '.' ],
        ['.', '.', '.', '.', '*', '*', '*' ],
        ])
    end

    it 'should solve example 5' do
      input = {
        :rows => 10,
        :columns => 10,
        :mines => 82
      }
      solution = solver.solve(input)
      expect(solution).to eq([
        ['c', '.', '*', '*', '*', '*', '*', '*', '*', '*' ],
        ['.', '.', '*', '*', '*', '*', '*', '*', '*', '*' ],
        ['.', '.', '*', '*', '*', '*', '*', '*', '*', '*' ],
        ['.', '.', '*', '*', '*', '*', '*', '*', '*', '*' ],
        ['.', '.', '*', '*', '*', '*', '*', '*', '*', '*' ],
        ['.', '.', '*', '*', '*', '*', '*', '*', '*', '*' ],
        ['.', '.', '*', '*', '*', '*', '*', '*', '*', '*' ],
        ['.', '.', '*', '*', '*', '*', '*', '*', '*', '*' ],
        ['.', '.', '*', '*', '*', '*', '*', '*', '*', '*' ],
        ['*', '*', '*', '*', '*', '*', '*', '*', '*', '*' ]
        ])
    end

    it 'should solve example 1 3 2' do
      input = {
        :rows => 1,
        :columns => 3,
        :mines => 2
      }
      solution = solver.solve(input)
      expect(solution).to eq([['c', '*', '*']])
    end
  end

  describe '#mark_locations' do
    it 'should change the matrix' do
      matrix = [
        ['1', '2', '3'],
        ['6', '5', '4'],
        ['7', '8', '9']
      ]

      new_matrix = solver.mark_locations(matrix, [[1,2], [2,2]], '.')
      expect(new_matrix).to eq([
        ['1', '2', '3'],
        ['6', '5', '.'],
        ['7', '8', '.']
        ])
    end
  end

  describe '#get_new_touching_locs' do
    it 'should return 8 nodes for a middle square' do
      input = {
        :rows => 3,
        :columns => 3
      }

      matrix = [
        ['*', '*', '*'],
        ['*', '.', '*'],
        ['*', '*', '*']
      ]
      touching_locs = solver.get_new_touching_locs(matrix, [2, 2], input)
      expect(touching_locs.size).to eq(2)
      expect(touching_locs).to include([1, 2])
      expect(touching_locs).to include([2, 1])
    end
  end

  describe '#get_touching_locs' do
    it 'should return 8 nodes for a middle square' do
      input = {
        :rows => 3,
        :columns => 3
      }
      touching_locs = solver.get_touching_locs([1, 1], input)
      expect(touching_locs.size).to eq(8)
      expect(touching_locs).to include([0, 0])
      expect(touching_locs).to include([0, 1])
      expect(touching_locs).to include([0, 2])
      expect(touching_locs).to include([1, 0])
      expect(touching_locs).to include([1, 2])
      expect(touching_locs).to include([2, 0])
      expect(touching_locs).to include([2, 1])
      expect(touching_locs).to include([2, 2])
    end


    it 'should return 5 nodes when touching top border' do
      input = {
        :rows => 3,
        :columns => 3
      }
      touching_locs = solver.get_touching_locs([0, 1], input)
      expect(touching_locs.size).to eq(5)
      expect(touching_locs).to include([0, 0])
      expect(touching_locs).to include([0, 2])
      expect(touching_locs).to include([1, 0])
      expect(touching_locs).to include([1, 1])
      expect(touching_locs).to include([1, 2])
    end

    it 'should return 3 nodes when touching bottom right corner' do
      input = {
        :rows => 3,
        :columns => 3
      }
      touching_locs = solver.get_touching_locs([2, 2], input)
      expect(touching_locs.size).to eq(3)
      expect(touching_locs).to include([1, 1])
      expect(touching_locs).to include([1, 2])
      expect(touching_locs).to include([2, 1])
    end
  end

  describe '#parse' do
    let(:input_file) {"minesweeper/sample.in"}

    it 'should parse a line from the sample' do
      File.open(input_file, 'r') do |input|
        input.readline
        result = solver.parse(input)
        expect(result[:rows]).to eq(5)
        expect(result[:columns]).to eq(5)
        expect(result[:mines]).to eq(23)
      end
    end
  end

  describe '#dump' do
    let(:output) {double('StringIO')}

    it 'should write the grid to output' do
      output.should_receive(:write).with("\n").ordered
      output.should_receive(:write).with(".*.").ordered
      output.should_receive(:write).with("\n").ordered
      output.should_receive(:write).with("c.*").ordered
      output.should_receive(:write).with("\n").ordered
      output.should_receive(:write).with("*..").ordered

      solution = [
        ['.', '*', '.'],
        ['c', '.', '*'],
        ['*', '.', '.'],
      ]

      solver.dump(output, solution)
    end

    it 'should write impossible if no solution' do
      output.should_receive(:write).with("\n").ordered
      output.should_receive(:write).with('Impossible').ordered

      solver.dump(output, false)
    end
  end
end
