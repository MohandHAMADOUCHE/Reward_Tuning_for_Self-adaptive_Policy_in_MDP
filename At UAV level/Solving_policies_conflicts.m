function [Policy1_without_conflicts, Policy2_without_conflicts , Policy3_without_conflicts] = Solving_policies_conflicts(Policy_G1, Policy_G2, Policy_G3,...
    Q1, Q2, Q3, R1, R2, R3, P1, P2, P3, discount, Proba_sys, Proba_detect_obs, Camera_failure, P_bat)
                                                                                                                                   
% Table de conflits
[constraint_table] = conflits_Table;

[Nav_in_conflit, Land_in_conflit, Track_in_conflit, statesinconflict_Nav, statesinconflict_Land, statesinconflict_Track] = ...
                                                check_conflicts(Policy_G1, Policy_G2, Policy_G3, constraint_table, Proba_sys, Proba_detect_obs, Camera_failure, P_bat);
                                            
    Nav_in_conflit
    Land_in_conflit
    Track_in_conflit

    if (Nav_in_conflit)
        Q_to_update = Q1;
        Reward      = R1; 
        Proba       = P1;
        statesinconflict = statesinconflict_Nav;
        action_NOP_in_Nav = 9; 
        [policy_after_up, Q_updated, Reward_updated] = Resolve_Conflicts(Q_to_update, Reward, Proba, ...
                                                                            discount, statesinconflict, action_NOP_in_Nav);
        Policy1_without_conflicts = Global_Actions_MDP_Nav(policy_after_up);

    else
        Policy1_without_conflicts = Policy_G1;
    end
    if (Camera_failure)
    Q_to_update = Q1;
        Reward      = R1; 
        Proba       = P1;
        statesinconflict(4) = 1; statesinconflict(10) = 1;    % S4 wpF & S10 WPj;
        alternative_action = 6;   % 6 : A10; RTH;
        [policy_after_up, Q_updated, Reward_updated] = Resolve_Conflicts(Q_to_update, Reward, Proba, ...
                                                                            discount, statesinconflict, alternative_action);
        Policy1_without_conflicts = Global_Actions_MDP_Nav(policy_after_up);
    end

    if (Land_in_conflit)
        Q_to_update = Q2;
        Reward      = R2; 
        Proba       = P2;
        statesinconflict = statesinconflict_Land;
        action_NOP_in_Land = 8; 
        [policy_after_up, Q_updated, Reward_updated] = Resolve_Conflicts(Q_to_update, Reward, Proba, ...
                                                                            discount, statesinconflict, action_NOP_in_Land);
        Policy2_without_conflicts = Global_Actions_MDP_Land(policy_after_up);
    else
        Policy2_without_conflicts = Policy_G2;
    end

    if (Track_in_conflit)
        Q_to_update = Q3;
        Reward      = R3; 
        Proba       = P3;
        statesinconflict = statesinconflict_Track;
        action_NOP_in_Track = 11; 
        [policy_after_up, Q_updated, Reward_updated] = Resolve_Conflicts(Q_to_update, Reward, Proba, ...
                                                                            discount, statesinconflict, action_NOP_in_Track);
        Policy3_without_conflicts =  Global_Actions_MDP_Track(policy_after_up);
    else
        Policy3_without_conflicts = Policy_G3;
    end
    
end