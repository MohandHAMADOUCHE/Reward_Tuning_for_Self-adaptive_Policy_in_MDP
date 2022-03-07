

function main(signal_to_adapt, Policy_Type) 
% Arguments -------------------------------------------------------------
% signal_to_adapt = 0; NOK for adaptation to the SWARM
%                 = 1; OK for adaptation to the SWARM
%   Policy_Type = 1; RTH
%               = 2; Landing 
%               = 3; Track another Target 
% arguments checking

if  nargin == 1 && signal_to_adapt  > 0
  disp('----------------------------------------------------------')
  disp('main ERROR: signal_to_adapt exist ! you must add Policy_Type')
  disp('----------------------------------------------------------')
elseif nargin > 1 && Policy_Type < 1 && Policy_Type > 3 
  disp('----------------------------------------------------------')
  disp('main ERROR: Policy_Type musst be 1 or 2 or 3')
  disp('----------------------------------------------------------')
elseif  nargin < 1 || nargin > 2 
  disp('----------------------------------------------------------')
  disp('main ERROR: use only two argument Policy_Type and signal_to_adapt')
  disp('----------------------------------------------------------')
else
    if (signal_to_adapt == 0); Policy_Type = 0; end
    %% UAV i receivce signal to change its policy   
    % ex. change action of the UAV 1
    % ID_UAV = 1
    ID_UAV = 1;

    lack_Energy = 1;
    
    % fix the target to track
    [Target, nbr_target] = Targets_SWARM ();
    P_detect_target = 0;
    target_t = 0;
    for i=1:nbr_target 
        if ((Target(i,8) == 0) && (Target(i,ID_UAV+1) > P_detect_target))
            target_t = i;
            P_detect_target = Target(i,ID_UAV+1);
        end
    end
    Target(target_t,8) = ID_UAV;
    target_to_track = target_t;

    [U1_Policy_Nav_, U1_Policy_Land_ , U1_Policy_Track_,  U1_Q_Nav , U1_Q_Land, U1_Q_Track, U1_R_Nav, U1_R_Land, U1_R_Track,...
        U1_P_Nav, U1_P_Land, U1_P_Track, U1_discount, U1_Proba_sys, U1_Proba_detect_obs] = Compute_UAV_Policies(ID_UAV, Target, target_to_track);
    
    if signal_to_adapt == 1 || lack_Energy == 1
    % senario : the Target (target_to_track = 1) is tracked by the UAV (ID_UAV = 5)  
    Target(target_to_track,8) = 5;
    [U1_Policy_Nav_s, U1_Policy_Land_s , U1_Policy_Track_s, U1_Q_Nav_s, U1_Q_Land_s, U1_Q_Track_s, ...
        U1_R_Nav_s, U1_R_Land_s, U1_R_Track_s, MDP_adapted] = Auto_Adapt_ToSWARM (ID_UAV, U1_Policy_Nav_, U1_Policy_Land_ , ....
        U1_Policy_Track_, U1_Q_Nav , U1_Q_Land, U1_Q_Track, U1_R_Nav, U1_R_Land, U1_R_Track, U1_P_Nav, U1_P_Land, U1_P_Track, U1_discount, signal_to_adapt, Policy_Type, Target, lack_Energy);
    else  
        U1_Policy_Nav_s = U1_Policy_Nav_ ; U1_Policy_Land_s = U1_Policy_Land_ ; U1_Policy_Track_s = U1_Policy_Track_;
        U1_Q_Nav_s = U1_Q_Nav; U1_Q_Land_s = U1_Q_Land; U1_Q_Track_s = U1_Q_Track;
        U1_R_Nav_s = U1_R_Nav; U1_R_Land_s = U1_R_Land; U1_R_Track_s = U1_R_Track;

    end
    %% solving conflicts 
    % default MDP to keep its policy 
    if (exist ('MDP_adapted')) == 0; MDP_adapted = 3; end   

    [U1_Policy_Nav_without_conflicts, U1_Policy_Land_without_conflicts, U1_Policy_Track_without_conflicts] = Solving_policies_conflicts(U1_Policy_Nav_s, U1_Policy_Land_s, U1_Policy_Track_s,...
         U1_Q_Nav_s, U1_Q_Land_s, U1_Q_Track_s, U1_R_Nav_s, U1_R_Land_s, U1_R_Track_s, U1_P_Nav, U1_P_Land, U1_P_Track, U1_discount, U1_Proba_sys, U1_Proba_detect_obs, MDP_adapted)

end
end
