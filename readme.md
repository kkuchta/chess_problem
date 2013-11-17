## Usage
`ruby tester.rb` will run the main comparison of the two algorithms.  It checks that they find the same result (which was what I was testing in the first place).

## Background
So, a friend of mine messaged me about an interview problem he'd been given, and he was pretty sure the only solution was brute force.  I was pretty sure there was a faster way, and I was trying to explain it to him.  It was hard to do over just chat without a whiteboard, and he had to go do something for a couple hours, so I figured I'd just implement it and prove to both of us that it worked.  That is this repo.

## Problem Statement
Consider a standard chess board.  On each square is some number of grains of wheat.  You start in the upper-left corner and need to get to the bottom right corner.  At each point, you can move either one square down or one square to the right.  Find the path that gets you the most grains of wheat.

Programatic specifics: the board is an NxM array of arrays of integers.  Find a path from `arr[0][0]` to `arr[rows-1][cols-1]` that, if you total the integers along it, maximizes the total.  From `arr[a][b]`, you can only go to `arr[a+1][b]` and `arr[a][b+1]`.

## General
For discussion (and coding purposes), consider the following definitions:
- x and y are the distance from the upper-left-hand corner of the grid.
- max_x and max_y are width-1 and height-1 respectively
- next(x,y) gets the next possible positions from the current one.

## Brute Force
This solution is easy: try all possible paths from the starting point to the ending point.  It's also quite inefficient.  The most obvious way to do this is to recurse from each square to its possible succesor squares (moves), and return the option that gives the best total.

## Backwards
This solution is conceptually easy, but has a lot of room for off-by-one type errors.  It's also linear time.

The gist is that you want to find the expected value of every square.  That's the value you would get if you took the optimal path from that square to the end.  You'll note that the optimal value of a square is equal to its own value on the problem board plus the greatest of the expected values of its two possible moves.  That is to say, the EV of a given square only depends on its next two squares.

Of course, the EV of the bottom right square is trivial: it's just the problem board value of that square.  The EV of the squares along the bottom edge and right edges can be determined from that, since each depends only on one other square.  And once you have the bottom + right edges, you just start iteratively filling in the EV for each square whose next moves already have an EV.

Pretty soon, the board is full of expected values.  Now you just start at the top left and, at each square, take the move that goes to the largest expected value.  That's your optimal path.

### Consideration
It's a pain in the ass to do the bottom row, then the right row, then corn-row my way back up to the top.  So, when implementing this thing, I decided to do a sort of backwards depth-first traversal like so:

```
0 0 0   0 0 0   0 0 x   0 x x   x x x
0 0 0   0 0 x   0 x x   x x x   x x x
0 0 x   0 x x   x x x   x x x   x x x
```

It's the same principal: calculate EVs on positions where the next moves already have EVs; it's just easier to implement.

## Analysis
So, Backwards is linear: it requires one traversal of each square to build the EVs (O(n)), then a single run of the correct path (O(sqr(n)).  Brute Force is exponentialish.  I decided to graph it for fun:

![chart](http://i.imgur.com/636cwsP.png)

You'll note that brute force goes up in an exponentialish fashion, whereas backwards appears flat.  It's actually linear, but the two diverged too quickly to make a graph that would show that.

## Notes
### Procedural Style
This would have been way cleaner if I'd built it just a little more object oriented, (eg, had a board object with a few manipulation methods), but I wanted this to be as close to the problem statement (array of arrays) as possible.  So, the functions all take in everything they need to do their job as parameters.

### General Cleanliness
This was an hour or so of work to prove a point, not a large scale web app, so it's a little messy.
