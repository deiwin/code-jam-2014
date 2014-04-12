require './cookie_clicker/cookie_clicker'

describe CookieClicker do
  let(:solver) {CookieClicker.new}

  describe '#solve' do
    it 'should solve example1' do
      input = {
        :farm_price => 30,
        :farm_rate => 1,
        :goal => 2
      }

      solution = solver.solve(input)
      expect(solution).to be_within(10**-6).of(1)
    end

    it 'should solve example2' do
      input = {
        :farm_price => 30,
        :farm_rate => 2,
        :goal => 100
      }

      solution = solver.solve(input)
      expect(solution).to be_within(10**-6).of(39.1666667)
    end

    it 'should solve example3' do
      input = {
        :farm_price => 30.5,
        :farm_rate => 3.14159,
        :goal => 1999.19990
      }

      solution = solver.solve(input)
      expect(solution).to be_within(10**-6).of(63.9680013)
    end

    it 'should solve example4' do
      input = {
        :farm_price => 500,
        :farm_rate => 4,
        :goal => 2000
      }

      solution = solver.solve(input)
      expect(solution).to be_within(10**-6).of(526.1904762)
    end
  end

  describe '#parse' do
    let(:input_file) {"cookie_clicker/sample.in"}

    it 'should read in input' do
      File.open(input_file, 'r') do |input|
        input.readline
        result = solver.parse(input)
        expect(result[:farm_price]).to eq(30.0)
        expect(result[:farm_rate]).to eq(1.0)
        expect(result[:goal]).to eq(2.0)
      end
    end
  end

  describe '#dump' do
    let(:output) {double('StringIO')}

    it 'should write number with 7 decimal places' do
      output.should_receive(:write).with('1.1000000')
      solver.dump(output, 1.1)
    end

    it 'should write cut at 7 decimal places' do
      output.should_receive(:write).with('1.1000001')
      solver.dump(output, 1.10000009)
    end
  end
end
