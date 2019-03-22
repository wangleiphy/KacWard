include("./load.jl")
using Lattices: Lattice, SquareLattice

takebit(index::Int, ibit::Int) = (index >> (ibit-1)) & 1

function energy(N::Int, K::Float64, config::Int, lattice::Lattice)
    res = 0.0
    for i in 1:N, n in 1:2
        j = lattice.Nbr[n, i]
        if j > 0
            res += K*(2*takebit(config, i-1)-1) * (2*takebit(config, j-1)-1)
        end
    end
    res 
end

function lnZ(N, K, lattice::Lattice)
    offset = 2*K*(N-sqrt(N))
    #println("offset: ", offset)
    #res = sum(exp.(energy.(N, K, 0:(1<<N-1), lattice).-offset))
    res = 0.0
    for config in 0:(1<<N-1)
        res += exp(energy(N, K, config, lattice)-offset)
    end
    offset + log(res)
end

function test()
    L = 4
    N = L^2 
    K = 1.0
    lattice = SquareLattice{:open}(L, L)
    println(lnZ(N, K, lattice)/N)
end
test()
