include("./lattice.jl")

takebit(index, ibit) = (index >> (ibit-1)) & 1

function energy(N, K, config, lattice)
    res = 0.0
    for i in 1:N
        for n in 1:2
            j = lattice[n, i]
            if j > 0
                res += K*(2*takebit(config, i-1)-1) * (2*takebit(config, j-1)-1)
            end
        end
    end
    res 
end

function lnZ(N, K, lattice)
    offset = 2*K*(N-sqrt(N))
    res = 0.0
    println("offset: ", offset)
    for config in 0:(1<<N-1)
        #println(config, ' ', energy(N, K, config, lattice))
        res += exp(energy(N, K, config, lattice)-offset)
    end
    offset + log(res)
end

L = 4
N = L^2 
K = 1.0
lattice = build_open(L)

println(lnZ(N, K, lattice)/N)
