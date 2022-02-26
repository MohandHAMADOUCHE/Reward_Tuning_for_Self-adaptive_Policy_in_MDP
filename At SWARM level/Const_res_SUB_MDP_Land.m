%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%    construction et resolution du SUB-MDP RECHERCHE ZONE ATTERRISSAGE
%-------------------------------------------------------

function  [Policy_G2, Policy2, V2, Q2, P2, R2] = Const_res_SUB_MDP_Land(proba_vect_Land, reward_vect_Land, ...
    nbr_S_Land, nbr_A_Land, discount, method)


 P2(:,:,:) = zeros(nbr_S_Land, nbr_S_Land, nbr_A_Land);

%TAKE-OFF (A1)
P2(1,1,1) = 1-proba_vect_Land(1); P2(1,2,1) = proba_vect_Land(1);

% Suivi trajectoire (A2)
P2(2,1,2) = 1 - proba_vect_Land(1); P2(2,3,2) = proba_vect_Land(1); 
P2(3,3,2) = proba_vect_Land(2); P2(3,4,2) = 1 - proba_vect_Land(2);
P2(5,3,2) = proba_vect_Land(2); P2(5,4,2) = 1 - proba_vect_Land(2);
P2(8,3,2) = proba_vect_Land(2); P2(8,4,2) = proba_vect_Land(3);   P2(8,10,2) = 1 - (proba_vect_Land(2) + proba_vect_Land(2)) ;

        
% RECHERCHE ZONE ATTERRISSAGE (A6) 
P2(6,7,3) = proba_vect_Land(3); P2(6,8,3) = 1 - proba_vect_Land(3);
        
% RECHERCHE DU "T" POUR ATTERRISSAGE (A5)
P2(3,5,4)   = proba_vect_Land(4); P2(3,6,4)  = 1 - proba_vect_Land(4);
P2(4,11,4)  = proba_vect_Land(4); P2(4,6,4)  = 1 - proba_vect_Land(4);
P2(12,11,4) = proba_vect_Land(4); P2(12,6,4) = 1 - proba_vect_Land(4);

% REPLANNING + LANDING (A8)
P2(7,9,5) = proba_vect_Land(7);

% LANDING (A7)
P2(5,9,6) = proba_vect_Land(7); P2(11,9,6) = proba_vect_Land(7); 

% A20 Hovering 
P2(4,12,7) = proba_vect_Land(6); P2(4,10,7) = 1 - proba_vect_Land(6);
P2(8,12,7) = proba_vect_Land(6); P2(8,10,7) = 1 - proba_vect_Land(6);
P2(12,12,7) = proba_vect_Land(6);  P2(12,10,7) = 1 -  proba_vect_Land(6);
% A24 : NOP
P2(5,5,8) = proba_vect_Land(7); P2(8,8,8) = proba_vect_Land(7);

% REWARD MATRIX  (Stratégie SAFETY)
R2(:,:) = zeros(nbr_S_Land, nbr_A_Land);

R2(1,1) = reward_vect_Land(1); %A1
R2(2,2) = reward_vect_Land(2); %A2
R2(3,2) = reward_vect_Land(2); R2(3,4) = reward_vect_Land(4); % A2 & A5
R2(4,7) = reward_vect_Land(6); R2(4,4) = reward_vect_Land(4); % A20 & A5
R2(5,2) = reward_vect_Land(2); R2(5,6) = reward_vect_Land(5); % A2 & A7  % ajout 5 ?
R2(6,3) = reward_vect_Land(3); % A6
R2(7,5) = reward_vect_Land(5); % A8
R2(8,2) = reward_vect_Land(2); R2(8,7) = reward_vect_Land(6); R2(8,8) = reward_vect_Land(7); % A2 & A20 & A24 
%R2(9,)  = 0;
%R2(10,) = 0;
R2(11,6) = reward_vect_Land(5);  % A7 
R2(12,7) = reward_vect_Land(6); R2(12,4) = reward_vect_Land(4);  % A20 & A5 


  % S1 base
  % S2 wp1
  % S3 wpI
  % S4 wpF
  % S5 zone_I T OK
  % S6 zone T NOK
  % S7 zone OK
  % S8 zone NOK 
  % S9 landing
  % S10 S_Collision
  % S11 zone T OK
  % S12 WPj
if method == 1 
    [V2, Q2, Policy2] = mdp_policy_iteration(P2, R2, discount);
elseif method == 2
    [V2, Q2, Policy2] = mdp_value_iteration(P2, R2, discount);
else
    [V2, Q2, Policy2] = mdp_policy_iteration(P2, R2, discount);
end

Policy_G2 = Global_Actions_MDP_Land(Policy2);


end


