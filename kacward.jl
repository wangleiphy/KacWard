include("./load.jl")
using LinearAlgebra: logdet
using Lattices: Lattice, SquareLattice

L = 4
N = L^2
K = 1.0

lattice = SquareLattice{:open}(L, L)

nu = tanh(K)
alpha = exp(im*pi/4)*nu
uright = [[nu alpha 0 conj(alpha)]; 
      [0  0  0  0];
      [0  0  0  0];
      [0  0  0  0];
     ]

uup = [[0  0  0  0];
      [conj(alpha) nu alpha 0]; 
      [0  0  0  0];
      [0  0  0  0];
     ]

uleft = [[0  0  0  0];
      [0  0  0  0];
      [0 conj(alpha) nu alpha]; 
      [0  0  0  0];
     ]

udown = [[0  0  0  0];
      [0  0  0  0];
      [0  0  0  0];
      [alpha 0 conj(alpha) nu];
     ]

U = zeros(Complex{Float64}, 4*N, 4*N)
for k in 1:N
    for n in 1:4
        j = 4*(k-1) + n 
        U[j, j] = 1.0
        for nprime in 1:4
            #right 
            kprime = lattice.Nbr[1, k]
            if kprime != 0
                jprime = 4*(kprime -1) + nprime
                U[j, jprime] = uright[n, nprime]
            end
            #up
            kprime = lattice.Nbr[2, k]
            if kprime != 0
                jprime = 4*(kprime -1) + nprime
                U[j, jprime] = uup[n, nprime]
            end
            #left
            kprime = lattice.Nbr[3, k]
            if kprime != 0
                jprime = 4*(kprime -1) + nprime
                U[j, jprime] = uleft[n, nprime]
            end
            #down
            kprime = lattice.Nbr[4, k]
            if kprime != 0
                jprime = 4*(kprime -1) + nprime
                U[j, jprime] = udown[n, nprime]
            end
        end
    end 
end

#number of edges 2*(N-L) for open square lattice
println(log(2) + 2*(N-L)/N*log(cosh(K)) +  0.5*logdet(U)/N)
