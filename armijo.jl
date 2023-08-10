#
#   Armijo's Linesearch (for Gradient Method)
#

function armijo(x,f,gradfx,η,minstep,fx)
    ierror = 0
    t0 = time()

    η1 = η
    GD = η1 * norm(gradfx,2)^2
    α = 1.0

    while true
        q = x - α * gradfx
        fq = f(q)
        stptest = fq - fx + α * GD

        if stptest > 0.0
            α = 0.5 * α
            if α < minstep
                ierror = 1
                #println("Step lenght toot small!")
                et = time() - t0
                return(α,ierror,et)
            end
        else
            et = time() - t0
            return(α,ierror,et)
        end 
    end
end
