function [C, G ] = PSORBFN( Iterations,C1,C2,SwarmSize, Data, Class1Label,Class2Label )
%PSO  
%
% swarm(index of particle, [location, velocity, best position, best
% value], [x, y components or the value component])

    % initialize swarm
    for i = 1 : SwarmSize;
        swarm(i, 1, 1) = rand()*70;
        swarm(i, 1, 2) = rand();
    end

    % best value to something really high
    swarm(:, 4, 1) = 1000; 
    % set velocities to 0
    swarm(:, 2, :) = rand;

    %% Iterations
    for iter = 1 : Iterations
        fprintf('Iteration: %d\n',iter);
        %-- evaluating position & quality ---
        for i = 1 : SwarmSize
            swarm(i, 1, 1) = round(swarm(i, 1, 1) + swarm(i, 2, 1));     %update x position
            swarm(i, 1, 2) = swarm(i, 1, 2) + swarm(i, 2, 2);     %update y position
            
            % threshold values
            if(swarm(i,1,1) <= 1)
                swarm(i,1,1)=1;
            end
            if(swarm(i,1,2) <= 0)
                swarm(i,1,2)=.001;
            end   
            if(swarm(i,1,2) >100)
                swarm(i,1,2)=100;
            end
            if(swarm(i,1,1) >30)
                swarm(i,1,1)=30;
            end
            
            x = swarm(i, 1, 1);
            y = swarm(i, 1, 2);

            % evaluate fitness function here
            val = FitnessFunctionRBFN(x,y,Data,Class1Label,Class2Label);
            
            % update the best positions
            if val < swarm(i, 4, 1)                 
                swarm(i, 3, 1) = swarm(i, 1, 1);    
                swarm(i, 3, 2) = swarm(i, 1, 2);    
                swarm(i, 4, 1) = val;               
            end
        end

        % global best is the lowest 
        [~, gbest] = min(swarm(:, 4, 1));
        % updating velocity vectors
        for i = 1 : SwarmSize
            swarm(i, 2, 1) = rand*swarm(i, 2, 1) + C1*rand*(swarm(i, 3, 1) - swarm(i, 1, 1)) + C2*rand*(swarm(gbest, 3, 1) - swarm(i, 1, 1));   %x velocity component
            swarm(i, 2, 2) = rand*swarm(i, 2, 2) + C1*rand*(swarm(i, 3, 2) - swarm(i, 1, 2)) + C2*rand*(swarm(gbest, 3, 2) - swarm(i, 1, 2));   %y velocity component
        end
        
        % plot to see movements
        %plot(swarm(:, 1, 1), swarm(:, 1, 2), 'x')   % drawing swarm movements
        %axis([0,35000,0,32]);
        %pause(.2)
    end
    C=swarm(gbest, 3, 1);
    G=swarm(gbest, 3, 2);
end
