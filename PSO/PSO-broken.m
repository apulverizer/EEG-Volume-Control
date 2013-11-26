function [C, G ] = PSO(numParticles, iterations )
%PSO 
% INPUT: func,the fitness function
%        size, number of particles
    close all
    MaxC=35000;
    MaxG=32;
    C1=2;
    C2=2;

    ParticlePosition = rand(2,numParticles); 
    ParticleBestFitness = zeros(1,numParticles);
    % create initial particles at position
    for i = 1 : numParticles
        ParticlePosition(1,i)=randi(25,1);
        ParticlePosition(2,i)=randi(25,1);
        ParticleBestFitness(1,i) = 10000;
    end
    
    
    %ParticlePosition = rand(2,numParticles);  
    %ParticlePosition(1,:) = ParticlePosition(1,:)*MaxC;
    %ParticlePosition(2,:) = ParticlePosition(2,:)*MaxG;
    
    GlobalBest=[1000; 1000]; % inital global best
    ParticleBestPosition = ParticlePosition; % initial  position is best
    ParticleVelocity = zeros(2,numParticles); % inital velocity of 0
    ParticleNextVelocity = zeros(2,numParticles);
    
    % do PSO for however many iterations
    for j=1:iterations
        % get the fitness for each particle
        for i=1:numParticles
            % evaluate fitness function
            %fitness = func(ParticlePosition(:,i));
            fitness = (ParticlePosition(1,i) - 15)^2 + (ParticlePosition(2,i) - 20)^2;  
            
            
            % if the fitness funciton is greater than the best, then update the
            % best
            if(fitness<ParticleBestFitness(i))
                ParticleBestFitness(i)=fitness;
                ParticleBestPosition(:,i)=ParticlePosition(:,i);
            end
        end

        % get the best global position
        IndexBest = find(ParticleBestFitness == min(ParticleBestFitness));
        IndexBest = IndexBest(1);
        GlobalBest = ParticlePosition(:,IndexBest);
        if min(ParticleBestFitness)==0
            break;
        end


        % Get Next Velocity and Postition
        for i=1:numParticles
            ParticleNextVelocity(:,i)=ParticleVelocity(:,i)+(C1*rand*(ParticleBestPosition(:,i) -ParticlePosition(:,i)))+(C2*rand*(GlobalBest-ParticlePosition(:,i)));
            ParticlePosition(:,i) = ParticlePosition(:,i)+ParticleNextVelocity(:,i);
        end
        ParticleVelocity=ParticleNextVelocity;
        
        %plot(ParticlePosition(1,:),ParticlePosition(2,:),'x');
        %pause(.2);
    end
    
    % store output results
    C = GlobalBest(1);
    G = GlobalBest(2);
    %hold off;
end

