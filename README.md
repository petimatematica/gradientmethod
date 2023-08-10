# armijo.jl

This file contains a function called "armijo" that calculates a step length such that the Armijo search $f(x+\alpha d)\le f(x)+\eta \alpha\nabla f(x)^Td$ is satisfied.

## Parameters:

- **x (vector):** vector containing the current estimate to be minimized;
- **f (function):** objective function;
- **gradfx (Float64):** the value of the gradient evaluated at the current estimate;
- **$\eta$ (Float64):** Armijo condition parameter. It reflects the slope of the tangent line to the objective function;
- **minstep (Float64):** minimum allowed value for step size. If the step size becomes smaller than this value, the function will return an error;
- **fx (vector):** value of the objective function at point x.

## Output:

- **$\alpha$:** selected step size;
- **ierror:** error flag. Returns 1 if the step size is too small; otherwise, returns 0;
- **et:** time taken to determine the step size.

## Error Example:

If the step size becomes too small (less than minstep), the function returns an error flag ierror = 1. This might indicate that the method is struggling to make progress.

## Application example:

```julia
 include("armijo.jl")
# Defining the objective function and its gradient
f(x) = x^2
gradf(x) = 2x

# Starting point
x0 = 2.0
fx0 = f(x0)
gradfx0 = gradf(x0)

# Parameters for the armijo function
η = 0.1
minstep = 1e-5

# Calling the armijo function
α, ierror, et = armijo(x0, f, gradfx0, η, minstep, fx0)
```

## Remarks:

- The step size is initialized as $\alpha=1.0$ and is halved with each iteration until the Armijo condition is met;

- You can specify the initial step length, the constant used in the backtracking process ($0.5$ was used in this code), and the constant $\eta$ employed in the evaluation of the Armijo condition.

# goldstein.jl  

This file contains a function named "goldstein" that implements the Goldstein condition $f(x)+\eta_2\alpha\nabla f(x)^Td\le f(x+\alpha d)\le f(x)+\eta_2 \alpha\nabla f(x)^Td$ for step size selection and aims to ensure an adequate reduction in the objective function's value and a sufficient decrease in the inner product between the gradient and the search direction.

## Parameters

- **x (vector):** Current point in the iteration.
- **f (function):** Objective function to be minimized.
- **gradfx (Float64):** Gradient of the objective function at point x.
η (Float64): Parameter used to define the constants $\eta_1$ and $\eta_2$ for the Goldstein condition. The values of $\eta_1$ and $\eta_2$ are respectively $\eta$ and $1-\eta$.
minstep (Float64): Minimum allowed value for the step size. If the step size becomes smaller than this value, the function will return an error.
fx (vector): Value of the objective function at point $x$.

## Output:

- **α:** selected step size;
- **ierror:** error flag. Returns $1$ if the step size is too small; otherwise, returns $0$;
- **et:** time spent determining the step size.

## Error Example

If the step size becomes too small (less than minstep), the function will return an error flag with ierror = 1. This might suggest that the method is having difficulty progressing.

## Application example:

```julia
include(“goldstein.jl”)
# Defining the Rosenbrock objective function and its gradient
function rosenbrock(v)
    x, y = v
    return (1 - x)^2 + 100 * (y - x^2)^2
end

function grad_rosenbrock(v)
    x, y = v
    dfdx = -400 * x * (y - x^2) - 2 * (1 - x)
    dfdy = 200 * (y - x^2)
    return [dfdx, dfdy]
end

# Starting point
x0 = [1.5, 1.5]
fx0 = rosenbrock(x0)
gradfx0 = grad_rosenbrock(x0)

# Parameters for the goldstein function
η = 0.1
minstep = 1e-5

# Calling the goldstein function
α, ierror, et = goldstein(x0, rosenbrock, gradfx0, η, minstep, fx0)
```

## Remarks: 

- The step size is initialized as $\alpha=1.0$ and is adjusted with each iteration until the Goldstein conditions are met.

# gradientmethod.jl 

This file contains the function called descentgradient that implements the gradient method where the steplength is computated by linesearch. To invoke this function you need the following informations:

## Parameters:

- x (Vector): The initial estimation for the minimizer.
- f (Function): The objective function to be minimized.
- ∇f (Function): The gradient of the objective function.
- ϵ (Float64): The convergence tolerance.
- η (Float64): The step size parameter.
- maxiter (Int): The maximum number of iterations allowed.
- minstep (Float64): The minimum step length for line search.
- linesearch (Function): The line search function to determine the step size.

## Output:

The descentgradient function returns the following elements:

- x (Vector): The estimated minimizer.
- ierror (Int): An indicator of success or failure.
- info (DataFrame): A DataFrame containing information about optimization progress.
- fvals (Vector{Float64}): Objective function values at each iteration.
- gradnorm (Vector{Float64}): L2 norms of gradients at each iteration.
- stplen (Vector{Float64}): Step lengths used in each iteration.
- et (Float64): Elapsed time for optimization.
- seqx (Matrix{Float64}): A matrix storing the sequence of estimations at each iteration.

## Example:

```julia
include("descentgradient.jl")
# Define your objective function f(x) and its gradient ∇f(x)
# Define the line search function for step size determination
x_initial = rand(2)  # Initial estimation
ϵ = 1e-6  # Convergence tolerance
η = 0.1  # Step size parameter
maxiter = 1000  # Maximum number of iterations
minstep = 1e-5  # Minimum step length for line search
result = descentgradient(x_initial, f, ∇f, ϵ, η, maxiter, minstep, linesearch)
x_minimizer, ierror, info, elapsed_time, seqx = result
```

## Remark:

- The descentgradient function iteratively updates the estimation x by taking steps in the direction of the negative gradient.
- Convergence is determined by checking the euclidian norm of the gradient against the specified tolerance.
- The function handles cases of convergence, maximum iterations reached, and insufficient step lengths.

