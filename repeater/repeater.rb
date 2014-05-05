require './solver'

class Repeater
  include Solver

  def solve(input)
    heat_maps = input.map(&method(:get_heat_map_for_string))
    return nil unless same_keys(heat_maps)
    nr_letters = heat_maps.first.length
    nr_strings = heat_maps.length
    sum = 0
    for letter_i in 0..(nr_letters -1)
      letter_sum = 0
      heat_maps.each { |heat_map| letter_sum += heat_map[letter_i][1] }
      letter_average = (letter_sum / nr_strings.to_f).round
      heat_maps.each { |heat_map| sum += (letter_average - heat_map[letter_i][1]).abs }
    end
    sum
  end

  def dump(output, solution)
    if solution.nil?
      output.write('Fegla Won')
    else
      output.write(solution)
    end
  end

  def parse(input)
    nr_strings = input.readline.to_i
    result = []
    nr_strings.times do
      result << input.readline.strip
    end
    return result
  end

  private
  def get_heat_map_for_string(s)
    s.split(//).chunk(&:to_s).map do |key, value|
      [key, value.length]
    end
  end

  def same_keys(arr)
    first_keys = nil
    arr.all? do |element|
      if first_keys
        element.length == first_keys.length &&
        get_letters_for_heat_map(element) == first_keys
      else
        first_keys = get_letters_for_heat_map(element)
        true
      end
    end
  end

  def get_letters_for_heat_map(heat_map)
    heat_map.map { |heat| heat.first }
  end
end
