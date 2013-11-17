require './backwards_solver'
require './brute_force_solver'

start = {x:0,y:0}
num_boards = 5
width_and_height = 9

total_brute_time = 0
total_backwards_time = 0
bad_board = nil
(0...num_boards).each do
  width = width_and_height
  height = width_and_height

  board = (0..height-1).map do
    (0..width-1).map do
      rand(0..9)
    end
  end
  puts "\nTrying board:\n"
  pretty_print(board)

  start_time = Time.now
  backwards_path = find_path_backwards( board, start )
  total_backwards_time += Time.now - start_time

  start_time = Time.now
  brute_path = find_path_brute_force( board, start )[:points]
  total_brute_time += Time.now - start_time

  if backwards_path == brute_path
    puts "Same solution found"
  else
    puts "DIFFERENT SOLUTION!"
    bad_board = board
  end
end

unless bad_board.nil?
  puts "bad_board = "
  pretty_print(bad_board)
end

puts "Avg backwards time=#{total_backwards_time/num_boards}"
puts "Avg brute time=#{total_brute_time/num_boards}"
