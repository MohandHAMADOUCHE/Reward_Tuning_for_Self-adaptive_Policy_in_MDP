%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%    construction et resolution du SUB-MDP NAVIGATION 
%-------------------------------------------------------
 function [Policy_G1, Policy1, V1, Q1, P1, R1] = Const_res_SUB_MDP_Nav(proba_vect_Nav, reward_vect_Nav, nbr_S_Nav, nbr_A_Nav, discount, method)
 
 %----------- SUB-MDP NAVIGATION  -------------------
 P1(:,:,:) = zeros(nbr_S_Nav, nbr_S_Nav, nbr_A_Nav);

%TAKE-OFF (A1)
P1(1,1,1) = 1-proba_vect_Nav(1); P1(1,2,1) = proba_vect_Nav(1);

%SUIVI TRAJET + Detection OBSTACLE (LIDAR) A18 (A2 + A11)
P1(2,3,2) = proba_vect_Nav(1) -  proba_vect_Nav(2); P1(2,5,2) = proba_vect_Nav(2); P1(2,1,2) = 1 -  proba_vect_Nav(1);
P1(3,3,2) = proba_vect_Nav(3); P1(3,4,2) = (1 - proba_vect_Nav(3)) - proba_vect_Nav(2); P1(3,5,2) = proba_vect_Nav(2);
P1(4,4,2) = 1- proba_vect_Nav(2); P1(4,5,2) = proba_vect_Nav(2);
     

% SUIVI TRAJET + DETECTION OBSTACLE WITH FUSION (US+IR) A19 (A2 & A3)
P1(2,3,3) = proba_vect_Nav(4); 							P1(2,6,3) = 1 - proba_vect_Nav(4); 	P1(3,3,3) = proba_vect_Nav(3) * proba_vect_Nav(4);
P1(3,4,3) = (1- proba_vect_Nav(3)) * proba_vect_Nav(4); P1(3,6,3) = 1 - proba_vect_Nav(4) ;
P1(4,4,3) = proba_vect_Nav(4); 							P1(4,6,3) = 1 - proba_vect_Nav(4);
P1(6,3,3) = proba_vect_Nav(3); 							P1(6,5,3) = 1 - proba_vect_Nav(1);  P1(6,4,3) = (1- proba_vect_Nav(3)) - proba_vect_Nav(2); P1(6,10,3) = 1 - (P1(6,3,3)+P1(6,5,3)+P1(6,4,3));

% AVOID OBSTACLE (A4)
P1(5,7,4) = proba_vect_Nav(2); 								P1(5,9,4) = 1 -  proba_vect_Nav(2);
P1(7,7,4) = proba_vect_Nav(2);								P1(7,3,4) = proba_vect_Nav(3);
P1(7,4,4) = (1- proba_vect_Nav(3)) - proba_vect_Nav(2);
        
% LANDING (A7)
P1(3,8,5) = proba_vect_Nav(5); P1(4,8,5) = proba_vect_Nav(5);
        
% RETOUR BASE (A10)
P1(3,1,6) = proba_vect_Nav(3);	 			   P1(4,1,6) = proba_vect_Nav(3);
P1(3,3,6) = proba_vect_Nav(1) - proba_vect_Nav(3); P1(4,3,6) = proba_vect_Nav(1) - proba_vect_Nav(3);
P1(3,4,6) = 1 - proba_vect_Nav(1); 				   P1(4,4,6) = 1 - proba_vect_Nav(1);
P1(10,1,6) = proba_vect_Nav(1);  P1(10,10,6) = 1- proba_vect_Nav(1); 			

% Hovering & Detection OBSTACLE (A 21)
P1(4,10,7)  = proba_vect_Nav(2);	 P1(4,5,7) = 1 - proba_vect_Nav(2);		 
P1(10,10,7) = proba_vect_Nav(2);	 P1(10,5,7) = 1 - proba_vect_Nav(2);	

% Hovering & DETECTION OBSTACLE WITH FUSION  (A 22)
P1(4,10,8)  = proba_vect_Nav(4);	 P1(4,6,8) = 1 - proba_vect_Nav(4);		 
P1(10,10,8) = proba_vect_Nav(4);	 P1(10,6,8) = 1 - proba_vect_Nav(4);

% -NOP- (A 24)
P1(3,3,9) = proba_vect_Nav(5);	
P1(5,5,9) = proba_vect_Nav(5);	
P1(6,6,9) = proba_vect_Nav(5);	 		 
P1(7,7,9) = proba_vect_Nav(5);	 


% REWARD MATRIX  (Stratégie SAFETY)

R1(:,:) = zeros(nbr_S_Nav, nbr_A_Nav);

R1(1,1) = reward_vect_Nav(1); 
R1(2,2) = reward_vect_Nav(2); R1(3,2) = reward_vect_Nav(2); 
R1(2,3) = reward_vect_Nav(3); R1(3,3) = reward_vect_Nav(3);  R1(6,3) = reward_vect_Nav(3); 
R1(5,4) = reward_vect_Nav(4); R1(7,4) = reward_vect_Nav(4);  
R1(3,5) = reward_vect_Nav(5); R1(4,5) = reward_vect_Nav(5); 
R1(3,6) = reward_vect_Nav(6); R1(4,6) = reward_vect_Nav(6);  R1(10,6) = reward_vect_Nav(6); 
R1(4,7) = reward_vect_Nav(2); R1(10,7) = reward_vect_Nav(2);
R1(4,8) = reward_vect_Nav(3); R1(10,8) = reward_vect_Nav(3);
R1(3,9) = reward_vect_Nav(1); R1(5,9) = reward_vect_Nav(1); R1(6,9) = reward_vect_Nav(1); R1(7,9) = reward_vect_Nav(1);
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

if method == 1  
    [V1, Q1, Policy1] = mdp_policy_iteration(P1, R1, discount);
elseif method == 2
    [V1, Q1, Policy1] = mdp_value_iteration(P1, R1, discount);
else
    [V1, Q1, Policy1] = mdp_Q_learning_Nav(P1, R1, discount);
end 
    
Policy_G1 = Global_Actions_MDP_Nav(Policy1);

 end






