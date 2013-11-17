require './util'
require 'pry-debugger'
require 'pry'

# Just recurse all possible paths.
def find_path_brute_force( board, start_point )
  options = get_options( start_point, board )

  # Bottom right corner
  if options.length == 0
    return { points: [start_point], best_value: get_value( start_point, board ) }
  end

  # If there's only one option, this works fine still.
  first_result = find_path_brute_force( board, options.first )
  second_result = find_path_brute_force( board, options.last )
  if first_result[:best_value] > second_result[:best_value]
    return {
      points: [start_point] + first_result[:points],
      best_value: first_result[:best_value] + get_value( start_point, board )
    }
  else
    return {
      points: [start_point] + second_result[:points],
      best_value: second_result[:best_value] + get_value( start_point, board )
    }
  end
end


#puts find_path_brute_force( example, {x:0,y:0} )
