function [ V, Q, policy] = mdp_Q_learning_Nav(P, R, discount, N)

% mdp_Q_learning   Evaluation of the matrix Q, using the Q learning algorithm 
%
% Arguments
% -------------------------------------------------------------------------
% Let S = number of states, A = number of actions
%   P(SxSxA)  = transition matrix 
%              P could be an array with 3 dimensions or 
%              a cell array (1xA), each cell containing a sparse matrix (SxS)
%   R(SxSxA) or (SxA) = reward matrix
%              R could be an array with 3 dimensions (SxSxA) or 
%              a cell array (1xA), each cell containing a sparse matrix (SxS) or
%              a 2D array(SxA) possibly sparse  
%   discount  = discount rate in ]0; 1[
%   N(optional) = number of iterations to execute, default value: 10000.
%                 It is an integer greater than the default value. 
% Evaluation --------------------------------------------------------------
%   Q(SxA) = learned Q matrix 
%   V(S)   = learned value function.
%   policy(S) = learned optimal policy.

% S1 base
% S2 wp1
% S3 wpI
% S4 wpF
% S5 OBSTACLE_det
% S6 S_fusion
% S7 WP_avoidance
% S8 S_landing 
% S9 S_Collision
% S10 WPj

% check of arguments
if (discount <= 0 || discount >= 1)
    disp('--------------------------------------------------------')
    disp('MDP Toolbox ERROR: Discount rate must be in ]0,1[')
    disp('--------------------------------------------------------')   
elseif (nargin >= 4) && (N < 10000)
    disp('--------------------------------------------------------')
    disp('MDP Toolbox ERROR: N must be upper than 10000')
    disp('--------------------------------------------------------') 
else
    epsilon = 0.99;
    epsilon_decay = 0.9999; 

    % initialization of optional arguments
    if (nargin < 4); N=100000; end;      
    
    % Find number of states and actions
    if iscell(P)
        S = size(P{1},1);
        A = length(P);
    else
        S = size(P,1);
        A = size(P,3); 
    end;
    
    % Initialisations
    nbr_Ac = 0; 
    Q = zeros(S,A);
    dQ = zeros(S,A);
    % Initial state choice
    s = 1; % randi([1,S]);

    for n=1:N 

        % Reinitialisation of trajectories every 100 transitions
        if (mod(n,50)==0  || s == 8 || s ==9  ); s = 1; end;
     	
     	while (1)
        % Action choice : greedy with increasing probability
        % probability 1-(1/log(n+2)) can be changed
        
        	pn = rand(1);
	        control = epsilon *(epsilon_decay)^n;
	        if (pn > (control))
	          [nil,a] = max(Q(s,:));
	        else
	            [a] = actions_navigation(s);
	        end;
 
	        % Simulating next state s_new and reward associated to <s,s_new,a> 
	        p_s_new = rand(1);
	        p = 0; 
	        s_new = 0;
	        while ((p < p_s_new)  && (s_new < S) )   % S8 S_landing   % S9 S_Collision && (s_new ~= 8) && (s_new ~= 9)
	            s_new = s_new+1;
	            if iscell(P)
	                p = p + P{a}(s,s_new);
	            else   
	                p = p + P(s,s_new,a);
	            end;
	        end; 
	        if iscell(R)
	            r = R{a}(s,s_new); 
	        elseif ndims(R) == 3
	            r = R(s,s_new,a); 
	        else
	            r = R(s,a); 
	        end;

	        % Updating the value of Q   
	        % Decaying update coefficient (1/sqrt(n+2)) can be changed
	        delta = r + discount*max(Q(s_new,:)) - Q(s,a);
            learning_rate = (1/sqrt(n+2));
	        dQ =learning_rate *delta;
	        Q(s,a) = Q(s,a) + dQ; 
	    
	    	if ((s == 8) || (s ==9)); break; end;

	        % Current state is updated
	        if s ==10
	            s = 1; 
	        else
	        s = s_new;
	        end
     	end   
    end;

    %compute the value function and the policy
    [V, policy] = max(Q,[],2);        
end;
