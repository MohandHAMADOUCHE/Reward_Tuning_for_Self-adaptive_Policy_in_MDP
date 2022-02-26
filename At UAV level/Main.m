 
%% compute UAV policies

[Policy_Nav_, Policy_Land_ , Policy_Track_, Q_Nav, Q_Land, Q_Track, R_Nav, ...
    R_Land, R_Track, P_Nav, P_Land, P_Track, discount, Proba_sys, Proba_detect_obs, Camera_failure, P_bat] = Compute_UAV_Policies()

%% solving conflicts 
   
 [Policy_Nav_without_conflicts, Policy_Land_without_conflicts , Policy_Track_without_conflicts] ...
    = Solving_policies_conflicts(Policy_Nav_, Policy_Land_, Policy_Track_, ...
    Q_Nav, Q_Land, Q_Track, R_Nav, R_Land, R_Track, P_Nav, P_Land, P_Track, discount, Proba_sys, Proba_detect_obs, Camera_failure, P_bat)
