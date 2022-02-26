%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%    construction et resolution du SUB-MDP TRACKING
%-------------------------------------------------------

function [Policy_G3, Policy3, V3, Q3, P3, R3] = Const_res_SUB_MDP_Track(proba_vect_Track, reward_vect_Track, nbr_S_Track, nbr_A_Track, discount, method)




%  SCENARIO 2 : ERREUR VIBRATION (ACTIVATION DE V3=STABILISATION)

P3(:,:,:) = zeros(nbr_S_Track, nbr_S_Track, nbr_A_Track);

%Take-Off A1
P3(1,1,1) = 1 - proba_vect_Track(1); P3(1,2,1) = proba_vect_Track(1);
        
%Suivi Trajectoire A2
P3(2,1,2) = 1 - proba_vect_Track(1); P3(2,3,2) = proba_vect_Track(1); 
P3(3,3,2) = 1 - proba_vect_Track(3);     P3(3,4,2) = proba_vect_Track(3);

%Hovering + Detection cible A23
P3(4,13,3) = 1 - proba_vect_Track(10); P3(4,5,3) = proba_vect_Track(10);

%tracking V0 
P3(5,13,4) = 1 - proba_vect_Track(4); P3(5,6,4) = proba_vect_Track(4);
P3(6,4,4)  = 1 - proba_vect_Track(4); P3(6,6,4) = proba_vect_Track(4);
            
%tracking V1
P3(5,7,5)  = proba_vect_Track(5);     P3(5,4,5)  = 1 - proba_vect_Track(5);
P3(6,6,5)  = 1 - proba_vect_Track(5); P3(6,7,5)  = proba_vect_Track(5);
P3(7,6,5)  = 1 - proba_vect_Track(5); P3(7,7,5)  = proba_vect_Track(5);
P3(8,6,5)  = 1 - proba_vect_Track(5); P3(8,7,5)  = proba_vect_Track(5);
P3(9,6,5)  = 1 - proba_vect_Track(5); P3(9,7,5)  = proba_vect_Track(5);
P3(10,6,5) = 1 - proba_vect_Track(5); P3(10,7,5) = proba_vect_Track(5);
P3(11,6,5) = 1 - proba_vect_Track(5); P3(11,7,5) = proba_vect_Track(5);
            
%tracking V2
P3(5,8,6)  = proba_vect_Track(6);     P3(5,4,6)  = 1 - proba_vect_Track(6);
P3(6,6,6)  = 1 - proba_vect_Track(6); P3(6,8,6)  = proba_vect_Track(6);
P3(7,6,6)  = 1 - proba_vect_Track(6); P3(7,8,6)  = proba_vect_Track(6);
P3(8,6,6)  = 1 - proba_vect_Track(6); P3(8,8,6)  = proba_vect_Track(6);
P3(9,6,6)  = 1 - proba_vect_Track(6); P3(9,8,6)  = proba_vect_Track(6);
P3(10,6,6) = 1 - proba_vect_Track(6); P3(10,8,6) = proba_vect_Track(6);
P3(11,6,6) = 1 - proba_vect_Track(6); P3(11,8,6) = proba_vect_Track(6);

%tracking V3        
P3(5,9,7)  = proba_vect_Track(7);     P3(5,4,7)  = 1 - proba_vect_Track(7);
P3(6,6,7)  = 1 - proba_vect_Track(7); P3(6,9,7)  = proba_vect_Track(7);
P3(7,6,7)  = 1 - proba_vect_Track(7); P3(7,9,7)  = proba_vect_Track(7);
P3(8,6,7)  = 1 - proba_vect_Track(7); P3(8,9,7)  = proba_vect_Track(7);
P3(9,6,7)  = 1 - proba_vect_Track(7); P3(9,9,7)  = proba_vect_Track(7);
P3(10,6,7) = 1 - proba_vect_Track(7); P3(10,9,7) = proba_vect_Track(7);
P3(11,6,7) = 1 - proba_vect_Track(7); P3(11,9,7) = proba_vect_Track(7);
        
 %tracking V4        
P3(5,10,8)  = proba_vect_Track(8);     P3(5,9,8)  = 1 - proba_vect_Track(8);
P3(6,6,8)  = 1 - proba_vect_Track(8); P3(6,10,8)  = proba_vect_Track(8);
P3(7,6,8)  = 1 - proba_vect_Track(8); P3(7,10,8)  = proba_vect_Track(8);
P3(8,6,8)  = 1 - proba_vect_Track(8); P3(8,10,8)  = proba_vect_Track(8);
P3(9,6,8)  = 1 - proba_vect_Track(8); P3(9,10,8)  = proba_vect_Track(8);
P3(10,6,8) = 1 - proba_vect_Track(8); P3(10,10,8) = proba_vect_Track(8);
P3(11,6,8) = 1 - proba_vect_Track(8); P3(11,10,8) = proba_vect_Track(8);
        
%tracking V5        
P3(5,11,9)  = proba_vect_Track(9);     P3(5,4,9)  = 1 - proba_vect_Track(9);
P3(6,6,9)   = 1 - proba_vect_Track(9); P3(6,11,9)  = proba_vect_Track(9);
P3(7,6,9)   = 1 - proba_vect_Track(9); P3(7,11,9)  = proba_vect_Track(9);
P3(8,6,9)   = 1 - proba_vect_Track(9); P3(8,11,9)  = proba_vect_Track(9);
P3(9,6,9)   = 1 - proba_vect_Track(9); P3(9,11,9)  = proba_vect_Track(9);
P3(10,6,9)  = 1 - proba_vect_Track(9); P3(10,11,9) = proba_vect_Track(9);
P3(11,6,9)  = 1 - proba_vect_Track(9); P3(11,11,9) = proba_vect_Track(9);
        
% (Retour Base A10)
P3(1,12,10)  = 0; P3(5,12,10)  = 0; P3(12,12,10) = 0;
P3(2,12,10)  = 1; P3(3,12,10)  = 1; P3(4,12,10)  = 1;
P3(6,12,10)  = 1; P3(7,12,10)  = 1; P3(8,12,10)  = 1;
P3(9,12,10)  = 1; P3(10,12,10) = 1; P3(11,12,10) = 1;

% (NOP A24)
P3(5,13,11)  = 1; 
P3(6,13,11)  = 1; 
P3(7,13,11)  = 1; 
P3(8,13,11)  = 1; 
P3(9,13,11)  = 1; 
P3(10,13,11)  = 1;
P3(11,13,11)  = 1;  
        

%Rewards matrix (activation V3 en S5V0 puis V1 à partir de S5V2 -cause
%ressources- )  
R3(:,:) = zeros(nbr_S_Track, nbr_A_Track);

R3(1,1)  = reward_vect_Track(1); 
R3(2,2)  = reward_vect_Track(2); R3(2,10) = reward_vect_Track(10); 
R3(3,2)  = reward_vect_Track(2); R3(3,10) = reward_vect_Track(10); 
R3(4,3)  = reward_vect_Track(3); R3(4,6)  = reward_vect_Track(2); R3(4,10) = reward_vect_Track(10); 
R3(5,4)  = reward_vect_Track(4); R3(5,5)  = reward_vect_Track(5); R3(5,6)  = reward_vect_Track(8); R3(5,7)  = reward_vect_Track(6); R3(5,8)  = reward_vect_Track(6); R3(5,9) = reward_vect_Track(6);
R3(6,4)  = reward_vect_Track(4); R3(6,5)  = reward_vect_Track(6); R3(6,6)  = reward_vect_Track(6); R3(6,7)  = reward_vect_Track(9); R3(6,8)  = reward_vect_Track(6); R3(6,9) = reward_vect_Track(6); R3(6,10) = reward_vect_Track(10);
R3(7,4)  = reward_vect_Track(4); R3(7,5)  = reward_vect_Track(5); R3(7,6)  = reward_vect_Track(6); R3(7,7)  = reward_vect_Track(9); R3(7,8)  = reward_vect_Track(6); R3(7,9) = reward_vect_Track(6); R3(7,10) = reward_vect_Track(10);
R3(8,4)  = reward_vect_Track(4); R3(8,5)  = reward_vect_Track(7); R3(8,6)  = reward_vect_Track(5); R3(8,7)  = reward_vect_Track(9); R3(8,8)  = reward_vect_Track(6); R3(8,9) = reward_vect_Track(6); R3(8,10) = reward_vect_Track(10);
R3(9,4)  = reward_vect_Track(4); R3(9,5)  = reward_vect_Track(7); R3(9,6)  = reward_vect_Track(6); R3(9,7)  = reward_vect_Track(9); R3(9,8)  = reward_vect_Track(6); R3(9,9) = reward_vect_Track(6); R3(9,10) = reward_vect_Track(10);
R3(10,4) = reward_vect_Track(4); R3(10,5) = reward_vect_Track(7); R3(10,6) = reward_vect_Track(6); R3(10,7) = reward_vect_Track(9); R3(10,8) = reward_vect_Track(6); R3(10,9) = reward_vect_Track(6); R3(10,10) = reward_vect_Track(10);
R3(11,4) = reward_vect_Track(4); R3(11,5) = reward_vect_Track(7); R3(11,6) = reward_vect_Track(6); R3(11,7) = reward_vect_Track(9); R3(11,8) = reward_vect_Track(6); R3(11,9) = reward_vect_Track(6); R3(11,10) = reward_vect_Track(10);
R3(13,3) = reward_vect_Track(3); R3(13,10) = reward_vect_Track(10);



  % S1 base
  % S2 wp1
  % S3 wpI
  % S4 wpF
  % S5 target T = cible T detectee 
  % S6 S5V0
  % S7 S5V1
  % S8 S5V2
  % S9 S5V3
  % S10 S5V4
  % S11 S5V5
  % S12 S_landing 
  % S13 S_WPj

if method == 1 
    [V3, Q3, Policy3] = mdp_policy_iteration(P3, R3, discount);
elseif method == 2
    [V3, Q3, Policy3] = mdp_policy_iteration(P3, R3, discount);
else
    [V3, Q3, Policy3] = mdp_policy_iteration(P3, R3, discount);
end
Policy_G3 = Global_Actions_MDP_Track(Policy3);

end