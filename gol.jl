
function glider(board::Array{Int8, 2})
        # put a glider in the top left-hand corner

        board[1,2] = 1
        board[2,3] = 1
        board[3,1:3] = 1
        
        return board 

end

function next_gen(board::Array{Int8, 2})

        shifts = [[1,1], [1,-1], [-1,1], [-1,-1], [0,1], [0,-1], [-1,0], [1,0]]
        states = [[1,2], [1,3], [0,3]]

        neighbours = zeros(board)
        for shift in shifts
                
                neighbours += circshift(board, shift)
                
        end

        new_board = zeros(board)
        for (index, cell) in enumerate(board)

                state = [cell, neighbours[index]]

                if state in states
                        new_board[index] = 1
                end

        end
        
        return new_board


end

function print_to_screen(board::Array{Int8, 2})

        n = size(board)[1]
        boardT = board.' # transpose to print

        for (i, val) in enumerate(boardT) 

                print(val == 1 ? "#":"-")

                if i % n == 0 println("\n") end

        end
end

function game_of_life(n=5, generations=20)
        # main function, size x size grid.
         
        if  (100 < n) | (n < 3) 
                println("Board size out of bounds")
                return
        end                
 
        board = zeros(Int8, n, n)
        board = glider(board)

        println("Generation 0")
        print_to_screen(board)       

        for i in 1:generations

                println("Generation ", i)
                board = next_gen(board)
                print_to_screen(board)                

        end
end

