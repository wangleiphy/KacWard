include("./lattice.jl")

N = 6
¦Â = 1.0 
¦Í = tanh(¦Â)
¦Á = exp(im*pi/4)*¦Í
u¡ú = [[¦Í ¦Á 0 conj(¦Á)]; 
      [0  0  0  0];
      [0  0  0  0];
      [0  0  0  0];
     ]

u¡ü = [[0  0  0  0];
      [conj(¦Á) ¦Í ¦Á 0]; 
      [0  0  0  0];
      [0  0  0  0];
     ]

u¡û = [[0  0  0  0];
      [0  0  0  0];
      [0 conj(¦Á) ¦Í ¦Á]; 
      [0  0  0  0];
     ]

u¡ý = [[0  0  0  0];
      [0  0  0  0];
      [0  0  0  0];
      [¦Á 0 conj(¦Á) ¦Í];
     ]

#Neighbor table
Nbr = build_Nbr(N)

U = zeros(4*N)
for k in 1:N
    for n in 1:N
        j = 4*(k-1) + n 
        U[j, j] = 1
        for nprime in 1:4
            #right 
            kprime = Nbr[1, k]
            if kprime != 0
                jprime = 4*(kprime -1) + nprime
                U[j, jprime] = u¡ú[n, nprime]
            end
            #up
            kprime = Nbr[2, k]
            if kprime != 0
                jprime = 4*(kprime -1) + nprime
                U[j, jprime] = u¡ü[n, nprime]
            end
            #left
            kprime = Nbr[3, k]
            if kprime != 0
                jprime = 4*(kprime -1) + nprime
                U[j, jprime] = u¡û[n, nprime]
            end
            #down
            kprime = Nbr[4, k]
            if kprime != 0
                jprime = 4*(kprime -1) + nprime
                U[j, jprime] = u¡ý[n, nprime]
            end
        end
    end 
end

println(0.5* logabsdet(U)[1] )
