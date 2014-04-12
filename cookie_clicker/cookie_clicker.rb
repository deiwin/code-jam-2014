require './solver'

class CookieClicker
  include Solver

  def solve(input)
    cookies = 0.0
    time_spent = 0.0
    rate = 2.0

    last_time_to_farm = 0.0
    last_time_to_goal = (input[:goal] - cookies) / rate
    loop do
      time_to_farm = last_time_to_farm + input[:farm_price] / rate
      rate += input[:farm_rate]
      time_to_goal = time_to_farm + input[:goal] / rate
      break if time_to_goal > last_time_to_goal || last_time_to_goal -time_to_goal < 10**-7
      last_time_to_farm = time_to_farm
      last_time_to_goal = time_to_goal
    end

    return last_time_to_goal
  end

  def parse(input)
    inputs = input.readline.split(/ /).map { |s| s.to_f }
    [:farm_price, :farm_rate, :goal].zip(inputs).to_h
  end

  def dump(output, solution)
    output.write('%.7f' % solution)
  end
end
