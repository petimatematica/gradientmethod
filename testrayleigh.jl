#
#   Test Rayleigh function
#

using LinearAlgebra, DataFrames, Random, Printf, Plots, BenchmarkProfiles, JLD2

include("armijo.jl")
include("goldstein.jl")
include("gradientmethod.jl")

nguess=10

sdmat = "dim"
sguess = "guess"
smatrix= "matrix"

# dimension
ndim = [5]

T = Float64[]
V = Float64[]

snd = MersenneTwister(135)
q=10

for B in 1:2 
    if B == 1 
        Ls = "MGA"
        println("Armijo")
        linesearch = armijo
    else 
        Ls = "MGG"
        println("Goldstein")
        linesearch = goldstein
    end

    for n in ndim 
        for k in 1:q
            A = rand(snd, n, n)
            A = 0.5 * (A + A')

            # Objective function  (Rayleigh)
            function f(x)
                fx = x' * A * x / (x' * x)
                return fx[1]
            end

            # Gradient of objective function
            ∇f(x) = 2 * (A * x - f(x) * x) / (x' * x)

            # Gradient method calling
            r = (1.e-7 - 1.e-8)
            ϵ = 1.e-7 #or ϵ = 1.e-8 + (r) / 5, ϵ = 1.e-8 + (r) / 10, ϵ = 1.e-8 + (r) / 15, ϵ = 1.e-8
            η = 1.e-4
            maxiter = 10000
            minstep = 1.e-6

            for m in 1:nguess
                x0 = randn(snd, n, 1)
                (x,ierror,info,etime,seqx) = descentgradient(x0,f,∇f,ϵ,η,maxiter,minstep,linesearch);
                filename = "echo/" * sdmat * string(n) * smatrix * string(k) * sguess * string(m) * Ls * ".jld2"
                @save filename info 

                if ierror > 0
                    push!(V, Inf)
                    push!(T, Inf)
                else
                    iters = size(seqx, 2)
                    push!(V, iters)
                    push!(T, etime)
                end   

                println("dimension $n evaluated time $etime  error $ierror")
            end
        end
    end
end

h=nguess*q*size(ndim,1);
W=[V[1:h] V[h+1:2h]]; #Matriz com iteradas
Z=[T[1:h] T[h+1:2h]]; #Matriz com os tempos

colors=[:royalblue1, :green2]

X = performance_profile(PlotsBackend(), W, ["MGA (dim=20)", "MGG (dim=20)"], xlabel="Iterated", ylabel="Solved problems [%]", legend=:bottomright, palette=colors)
Y = performance_profile(PlotsBackend(), Z, ["MGA (dim=20)", "MGG (dim=20)"], xlabel="CPU time ratio", ylabel="Solved problems [%]", legend=:bottomright, palette=colors)

plot(X, Y)