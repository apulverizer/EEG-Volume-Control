function [ output_args ] = FitnessTest( input_args )
x = input_args(1);
y = input_args(2);

% Rosenbrock valley in 2D
output_args = 100*(y-x^2)^2+(1-x)^2;

end

