# Note: this is done in a procedural style to match the original problem statement.
# An OO style would suit this very well, but this way lets us deal entirely with
# an NxM array of arrays, rather than a wrapper object.

# Board: an NxM array
# point: {x:1, y:2} (where 0s are the upper left corner of the board)

# Given point hash {x:1,y:2}, return 0, 1, or 2 point hashes indicating
# the next possible moves.
def get_options( point, board )
  options = []
  unless point[:x] == max_x(board)
    options << {x:point[:x]+1,y:point[:y]}
  end
  unless point[:y] == max_y(board)
    options << {x:point[:x],y:point[:y]+1}
  end
  options
end

def max_x( board )
  board.first.length - 1
end

def max_y( board )
  board.length - 1
end

def pretty_print( board )
  print "   "
  board.first.each_with_index do |_, i|
    print i.to_s + " "
  end
  print "\n\n"

  board.each_with_index do |row, y|
    puts "#{y}  " + row.map {|n| n.nil? ? '_' : n }.join( " " )
  end

  nil
end

def get_value( point, board )
  board[point[:y]][point[:x]]
end
def set_value( point, value, board )
  board[point[:y]][point[:x]] = value
end
