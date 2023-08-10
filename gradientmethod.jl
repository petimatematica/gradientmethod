#
#   Gradient Method with Linesearch
#

function descentgradient(x,f,∇f,ϵ,η,maxiter,minstep,linesearch)

    Gnorm = Float64[];
    fvals = Float64[];
    stplen = Float64[];
    #ters = Int64[];
    #inttime = Float64[NaN];

    seqx=x
    info = DataFrame()

    ierror = 0
    iter = 0  # Number of iterations
    push!(stplen,NaN)
    t0 = time()

    while true
        gradfx = ∇f(x)
        normgradfx = norm(gradfx,2)
        push!(Gnorm,normgradfx)
        fx = f(x)
        push!(fvals,fx)
        #println("$iter      $normgradfx     $fx")

        # Verifies if convergence was achieved
        if normgradfx < ϵ
            #println("Solution has found!")

            info.fvals = fvals
            info.gradnorm = Gnorm
            #info.inttime = inttime
            info.stplen = stplen 
            et = time() - t0
            return(x,ierror,info,et,seqx)
        end

        # Update iter count
        iter += 1

        #Verifies if maxiter was achieved
        if iter > maxiter
            ierror = 2
            #println("Maximum of iterations was achieved! Stopping...")

            info.fvals = fvals
            info.gradnorm = Gnorm
            info.stplen = stplen
            #info.inttime = inttime
            et = time() - t0
            return(x,ierror,info,et,seqx)
        end

        # Update sequence
        (α,ilserror,iet) = linesearch(x,f,gradfx,η,minstep,fx)
        push!(stplen,α)
        #push!(inttime,iet)

        if ilserror > 0
            ierror = 1
            #println("Step lenght toot small!")

            push!(fvals,NaN)
            info.fvals = fvals
            push!(Gnorm,NaN)
            info.gradnorm = Gnorm
            info.stplen = stplen
            #info.inttime = inttime
            et = time() - t0
            return(x,ierror,info,et,seqx)
        end

        x = x - α * gradfx
        seqx=[seqx x];

    end
end