function [t, y] = euler_solver(odefun, tspan, y0, dt)
% Solve differential equation y' = f(t,y), from time tspan = [t0 t_final], 
% with initial condition y0. Here odefun must be a function with signature 
% odefun(t,y), which for a scalar t and a vector y returns a column vector 
% corresponding to f(t,y). The solver uses the integration timestep dt. 
% Each row in the solution array y corresponds to a time returned in the 
% column vector t.

t = tspan(1):dt:tspan(2); % Vector of time points
Nt = length(t); % Number of time points
Ns = length(y0); % Number of states

y = zeros(Nt,Ns); % Initialize matrix to hold solution
y(1,:) = y0'; % Insert initial condition.
for i = 2:Nt
    y(i,:) = y(i-1,:) + odefun(t(i),y(i-1,:)')'*dt;
end