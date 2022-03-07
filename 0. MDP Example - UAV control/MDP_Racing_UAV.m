function [P,R] = MDP_Racing_UAV(r1,r2,w)

% MDP_Racing_UAV    Generate a Markov Decision Process example based on 
%                       a racing UAV
% Arguments -------------------------------------------------------------
%   S = number of states (default 3)
%   r1 = reward when UAV is in the 'Normal' state and action Fast is performed,
%         (default +2)
%   r2 = reward when Car is in the 'Instable' state and action Fast is performed,
%         (default -10)
%   w = probability of wind occurrence during a time period, in ]0, 1[, (default 0.5)
% Evaluation -------------------------------------------------------------
%   P(SxSxA) = transition probability matrix 
%   R(SxA) = reward matrix

% arguments checking
if nargin >= 1 && r1 <= 0
  disp('----------------------------------------------------------')
  disp('MDP ERROR: The reward value r1 must be upper than 0')
  disp('----------------------------------------------------------')
elseif nargin >= 2 && r2 <= 0    
  disp('-----------------------------------------------------------')
  disp('MDP ERROR: The reward value r2 must be upper than 0')
  disp('-----------------------------------------------------------')
elseif nargin >= 3 &&( w < 0 || w > 1  )  
  disp('--------------------------------------------------------')
  disp('MDP Toolbox ERROR: Probability p must be in [0; 1]')
  disp('--------------------------------------------------------') 
else

  % initialization of optional arguments
  S=3;
  if nargin < 3; w=0.5; end;
  if nargin < 2; r2=-10; end;
  if nargin < 1; r1=1; end;
   


  % Definition of Transition matrix P_Slow(:,:,1) associated to action Slow 
  %(action 1) and P_Fast(:,:,2) associated to action Fast (action 2)
  %                  |  1   0  0 |                      | 1-w  w   0 |
  %  P_Slow(:,:,1) = |  w  1-w 0 |  and P_Fast(:,:,2) = |  0   0   1 |
  %                  |  0   0  0 |                      |  0   0   0 |  
  
  P_Slow=zeros(S,S);
  P_Slow(1,1)=1;
  P_Slow(2,1)=w; P_Slow(2,2)=1-w;
  P_Fast=zeros(S,S);
  P_Fast(1,1)=1-w; P_Fast(1,2)=w;
  P=cat(3,P_Slow,P_Fast);

  % Definition of Reward matrix R_Slow associated to action Slow and 
  % R_Fast associated to action Fast

  %                | r1 |                      | 2*r1 |
  %  R_Slow(:,1) = | r1 |  and   R_Fast(:,2) = | 2*r1 |	              
  %                | 0  |                      |  r2  |
  R1=zeros(S,1);
  R1(1)=r1;   R1(2)=r1;
  R2=ones(S,1);
  R2(1)=2*r1;
  R2(2)=2*r1;
  R2(3)=r2;
  R=[R1 R2];
  
end

