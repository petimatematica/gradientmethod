# armijo.jl

This file contains a function called "armijo" that calculates a step length such that the Armijo search $f(x+\alpha d)\le f(x)+\eta \alpha\nabla f(x)^Td$ is satisfied.

## Parameters:

- **x (vector):** vector containing the current estimate to be minimized;
- **f (function):** objective function;
- **gradfx (Float64):** the value of the gradient evaluated at the current estimate;
- **$\eta$ (Float64):** Armijo condition parameter. It reflects the slope of the tangent line to the objective function;
- **minstep (Float64):** minimum allowed value for step size. If the step size becomes smaller than this value, the function will return an error;
- **fx (vector):** value of the objective function at point x.

## Return:

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
