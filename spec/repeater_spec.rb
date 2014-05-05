require './repeater/repeater'

describe Repeater do
  let(:solver) {Repeater.new}

  describe '#solve' do
    it 'should solve sample 1' do
      input = ['mmaw', 'maw']

      solution = solver.solve(input)
      expect(solution).to eq(1)
    end

    it 'should solve sample 2' do
      input = ['gcj', 'cj']

      solution = solver.solve(input)
      expect(solution).to eq(nil)
    end

    it 'should solve sample 3' do
      input = ['aaabbb','ab','aabb']

      solution = solver.solve(input)
      expect(solution).to eq(4)
    end

    it 'should solve sample 4' do
      input = ['abc', 'abc']

      solution = solver.solve(input)
      expect(solution).to eq(0)
    end

    it 'should solve sample 5' do
      input = ['aabc', 'abbc', 'abcc']

      solution = solver.solve(input)
      expect(solution).to eq(3)
    end

    it 'should round to closest integer' do
      input = ['aa', 'aa', 'a']

      solution = solver.solve(input)
      expect(solution).to eq(1)
    end

    it 'should round to closest integer' do
      input = ['aab', 'aabb', 'abb']

      solution = solver.solve(input)
      expect(solution).to eq(2)
    end

    it 'should be able to remove letters' do
      input = ['aaa', 'aa', 'a']

      solution = solver.solve(input)
      expect(solution).to eq(2)
    end
  end

  describe '#parse' do
    let(:input_file) {"repeater/sample.in"}
    it 'should return array with 2 strings' do
      File.open(input_file, 'r') do |input|
        input.readline
        result = solver.parse(input)
        expect(result.length).to eq(2)
        expect(result).to include("mmaw")
        expect(result).to include("maw")
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

    it 'should write fegla won if nil' do
      @output.should_receive(:write).with('Fegla Won')
      solver.dump(@output, nil)
    end
  end

  describe '#get_heat_map_for_string' do
    it 'should return number of occurences for each letter of a string' do
      result = solver.send(:get_heat_map_for_string, 'acccbb')
      result.should eql([
        ['a', 1],
        ['c', 3],
        ['b', 2]
        ])
    end

    it 'should allow same letter twice' do
      result = solver.send(:get_heat_map_for_string, 'acccbbcccc')
      result.should eql([
        ['a', 1],
        ['c', 3],
        ['b', 2],
        ['c', 4]
        ])
    end
  end

  describe '#same_keys' do
    it 'should return true if all hashes have the same number of elements' do
      result = solver.send(:same_keys, [[
        ['a', 1],
        ['c', 3],
        ['b', 2]
        ],[
        ['a', 1],
        ['c', 3],
        ['b', 2]
        ]])
      result.should eql(true)
    end

    it 'should return false if hashes have different lengths' do
      result = solver.send(:same_keys, [[
        ['a', 1],
        ['c', 3],
        ['b', 2]
        ],[
        ['a', 1],
        ['c', 3]
        ]])
      result.should eql(false)
    end

    it 'should return false if hashes have different keys, but same lengths' do
      result = solver.send(:same_keys, [[
        ['a', 1],
        ['c', 3],
        ['b', 2]
        ],[
        ['a', 1],
        ['b', 2],
        ['c', 3]
        ]])
      result.should eql(false)
    end
  end

  describe '#get_letters_for_heat_map' do
    it 'should return array of arrays first subelements' do
      result = solver.send(:get_letters_for_heat_map, [
        ['a', 1],
        ['c', 3],
        ['b', 2],
        ['c', 2]
        ])
      result.should eql(['a', 'c', 'b', 'c'])
    end
  end
end
