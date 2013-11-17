require './util'
require 'pry-debugger'
require 'pry'

def find_path_backwards( board, start_point )
  expected_value_board = board.map { |row| row.map {nil} }

  ending_point = {
    x: max_x(expected_value_board),
    y: max_y(expected_value_board)
  }
  next_points_up = [ending_point]
  while next_points_up.length > 0 do
    current_points = next_points_up
    next_points_up = []
    current_points.each do |point|

      options = get_options( point, expected_value_board )
      options_expected_values = options.map { |option| get_value(option, expected_value_board) }
      current_expected_value = (options_expected_values.max || 0) + get_value( point, board )

      set_value(
        point,
        current_expected_value,
        expected_value_board
      )
      next_points_up += backwards_options( board, point )
    end
    next_points_up.uniq!
  end

  def find_path( expected_value_board, start_point )
    options = get_options( start_point, expected_value_board )
    if options.length == 0
      return [start_point]
    elsif get_value(options.first, expected_value_board) > get_value(options.last, expected_value_board)
      return [start_point] + find_path(expected_value_board, options.first)
    else
      return [start_point] + find_path(expected_value_board, options.last)
    end
  end

  find_path expected_value_board, start_point
end

# Get all points that can move to this position
def backwards_options( board, point )
  options = []
  unless point[:x] == 0
    options << {x: point[:x]-1, y:point[:y]}
  end
  unless point[:y] == 0
    options << {x: point[:x], y:point[:y]-1}
  end
  options
end
