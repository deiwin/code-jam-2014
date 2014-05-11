require './part_elf/part_elf'

describe PartElf do
  let(:solver) {PartElf.new}

  describe '#solve' do
    it 'should solve sample 1' do
      input = {
        :elf_ancestors => 1,
        :ancestors => 2
      }

      solution = solver.solve(input)
      expect(solution).to eq(1)
    end

    it 'should solve sample 2' do
      input = {
        :elf_ancestors => 3,
        :ancestors => 4
      }

      solution = solver.solve(input)
      expect(solution).to eq(1)
    end

    it 'should solve sample 3' do
      input = {
        :elf_ancestors => 1,
        :ancestors => 4
      }

      solution = solver.solve(input)
      expect(solution).to eq(2)
    end

    it 'should solve sample 4' do
      input = {
        :elf_ancestors => 2,
        :ancestors => 23
      }

      solution = solver.solve(input)
      expect(solution).to eq(nil)
    end

    it 'should solve sample 5' do
      input = {
        :elf_ancestors => 123,
        :ancestors => 31488
      }

      solution = solver.solve(input)
      expect(solution).to eq(8)
    end
  end

  describe '#as_nth_power_of_2' do
    it 'should return 2 for 4' do
      expect(solver.as_nth_power_of_2(4)).to eq(2)
    end

    it 'should return 3 for 8' do
      expect(solver.as_nth_power_of_2(8)).to eq(3)
    end

    it 'should return 0 for 1' do
      expect(solver.as_nth_power_of_2(1)).to eq(0)
    end

    specify do
      expect{solver.as_nth_power_of_2(5)}.to throw_symbol(:not_a_power_of_2)
    end
  end


  describe '#power_of_2_larger_or_equal_than' do
    it 'should return 4 for 4' do
      expect(solver.power_of_2_larger_or_equal_than(4)).to eq(4)
    end

    it 'should return 8 for 7' do
      expect(solver.power_of_2_larger_or_equal_than(7)).to eq(8)
    end
  end

  describe '#to_lowest_terms' do
    it 'should return 1, 256 for 123, 31488' do
      expect(solver.to_lowest_terms(123, 31488)).to eq([1, 256])
    end
  end

  describe '#parse' do
    let(:input_file) {"part_elf/sample.in"}
    it 'should return input as an object' do
      File.open(input_file, 'r') do |input|
        input.readline
        result = solver.parse(input)
        expect(result.length).to eq(2)
        expect(result[:elf_ancestors]).to eq(1)
        expect(result[:ancestors]).to eq(2)
      end
    end
  end

  describe '#dump' do
    before(:each) do
      @output = StringIO.new
    end

    it 'should write number if result has one' do
      @output.should_receive(:write).with(7)
      solver.dump(@output, 7)
    end

    it 'should write number even if 0' do
      @output.should_receive(:write).with(0)
      solver.dump(@output, 0)
    end

    it 'should write impossible if nil' do
      @output.should_receive(:write).with("impossible")
      solver.dump(@output, nil)
    end
  end
end
