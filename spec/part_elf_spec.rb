require './1c/part_elf/part_elf'

describe PartElf do
  let(:solver) {PartElf.new}

  describe '#solve' do
    it 'should solve sample 1' do
      # input = {
      #   :old_less => 3,
      #   :new_less => 4,
      #   :tickets_less => 2
      # }

      # solution = solver.solve(input)
      # expect(solution).to eq(10)
    end
  end

  describe '#parse' do
    let(:input_file) {"1c/part_elf/sample.in"}
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
