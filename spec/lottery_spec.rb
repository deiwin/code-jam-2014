require './lottery/lottery'

describe Lottery do
  let(:solver) {Lottery.new}

  describe '#solve' do
    it 'should solve sample 1' do
      input = {
        :old_less => 3,
        :new_less => 4,
        :tickets_less => 2
      }

      solution = solver.solve(input)
      expect(solution).to eq(10)
    end

    it 'should solve sample 2' do
      input = {
        :old_less => 4,
        :new_less => 5,
        :tickets_less => 2
      }

      solution = solver.solve(input)
      expect(solution).to eq(16)
    end

    it 'should solve sample 3' do
      input = {
        :old_less => 7,
        :new_less => 8,
        :tickets_less => 5
      }

      solution = solver.solve(input)
      expect(solution).to eq(52)
    end

    it 'should solve sample 4' do
      input = {
        :old_less => 45,
        :new_less => 56,
        :tickets_less => 35
      }

      solution = solver.solve(input)
      expect(solution).to eq(2411)
    end

    it 'should solve sample 5' do
      input = {
        :old_less => 103,
        :new_less => 143,
        :tickets_less => 88
      }

      solution = solver.solve(input)
      expect(solution).to eq(14377)
    end
  end

  describe '#parse' do
    let(:input_file) {"lottery/sample.in"}
    it 'should return array with 2 strings' do
      File.open(input_file, 'r') do |input|
        input.readline
        result = solver.parse(input)
        expect(result.length).to eq(3)
        expect(result[:old_less]).to eq(3)
        expect(result[:new_less]).to eq(4)
        expect(result[:tickets_less]).to eq(2)
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
  end
end
