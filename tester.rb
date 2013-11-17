require './backwards_solver'
require './brute_force_solver'


#example = [
  #[4,2,3],
  #[2,7,1],
  #[3,1,4],
  #[4,5,6]
#]
start = {x:0,y:0}

#backwards_path = find_path_backwards( example, start )
#brute_path = find_path_brute_force( example, start )[:points]
#puts "backwards_path=#{backwards_path}"
#puts "brute_path=#{brute_path}"
#puts "#{brute_path==backwards_path}"

# 10 random boards
bad_board = nil
total_brute_time = 0
total_backwards_time = 0

num_boards = 5

(0...num_boards).each do
  width = 11
  height = 11

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
