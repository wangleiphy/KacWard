
function build_Nbr(N)
    #Neighbor table
    Nbr = zeros(Int8, 4, N*N)
    for k in 0:N*N-1
        x = rem(k, N) 
        y = div(k, N)
            
        #right
        if x+1 < N-1
            Nbr[1, k+1] = (x+1) + y*N +1 
        end

        #up 
        if y+1 < N-1
            Nbr[2, k+1] = x + (y+1)*N +1
        end

        #left
        if x-1 > 0
            Nbr[3, k+1] = (x-1) + y*N +1
        end

        #down
        if y-1 > 0
            Nbr[4, k+1] = x + (y-1)*N +1
        end
    end
    Nbr 
end 

#display(build_Nbr(4))
