function [ output_args ] = FitnessTest( input_args )
%FitnessTest The function used to verify that the PSO works correctly
% Inputs:
%   input_args: A 2 element array with x and y
% Output:
%   output_args: The fitness of the function (closest to 0 is best)
%
% Author: Aaron Pulver, Deep Tayal 12/4/13
x = input_args(1);
y = input_args(2);

% Rosenbrock valley in 2D
output_args = 100*(y-x^2)^2+(1-x)^2;

end

