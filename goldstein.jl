#
#   Goldstein's Linesearch (for Gradient Method)
#

function goldstein(x,f,gradfx,η,minstep,fx)
    ierror = 0
    t0 = time()

    η1 = η
    η2 = 1 - η   
    GD = norm(gradfx,2)^2
    α = 1.0;

    while true
        q = x - α * gradfx
        fq = f(q)
        stptestA = fq - fx + α * η2 * GD
        stptestB = fq - fx + α * η1 * GD #armijo inequality

        if (stptestA >= 0.0 && stptestB <= 0.0) 
            et = time() - t0
            return(α,ierror,et)
        else
            if stptestB > 0.0
                α = η1 * α
                if α < minstep
                    ierror = 1
                    et = time() - t0
                    return(α,ierror,et)
                end
            else
                α = α / η2
                if α < minstep
                    ierror = 1
                    et = time() - t0
                    return(α,ierror,et)
                end
            end
        end
    end
end
