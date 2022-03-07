function [Policy_Nav_, Policy_Land_ , Policy_Track_, Q_Nav_, Q_Land_, Q_Track_, R_Nav_, R_Land_, R_Track_, MDP_adapted] = modify_policy(Policy_Nav_, Policy_Land_, Policy_Track_, ...
             Q_Nav, Q_Land, Q_Track, R_Nav, R_Land, R_Track, P_Nav, P_Land, P_Track, discount, wished_action)
 

    switch  wished_action
        case 6
        %% wished_action = 6; 
            % 6: A10; RTH;      
        Q_to_update = Q_Nav;
        Reward      = R_Nav; 
        Proba       = P_Nav;
        statesinconflict = [4, 10];   % S4 wpF & S10 WPj;
        % Nav
        [policy_after_up, Q_updated, Reward_updated] = Resolve_Swarm_Conflicts(Q_to_update, Reward, Proba, ...
                                                                            discount, statesinconflict, wished_action);
        Policy_Nav_without_conflicts = Global_Actions_MDP_Nav(policy_after_up);
        Policy_Nav_ = Policy_Nav_without_conflicts;
        
        Q_Nav_ = Q_updated; Q_Land_ = Q_Land; Q_Track_ = Q_Track; 
        R_Nav_ = Reward_updated ; R_Land_ = R_Land; R_Track_ = R_Track; 
        MDP_adapted =  1; % Nav
        case 4
        %% wished_action = 4; 
            % 4: A5; RECHERCHE DU "T" POUR ATTERRISSAGE 
        Q_to_update = Q_Land;
        Reward      = R_Land; 
        Proba       = P_Land;
        statesinconflict = [4, 12];     % S4 wpF & S12 WPj
        % Land
        [policy_after_up, Q_updated, Reward_updated] = Resolve_Swarm_Conflicts(Q_to_update, Reward, Proba, ...
                                                                            discount, statesinconflict, wished_action);
        Policy_Land_without_conflicts = Global_Actions_MDP_Land(policy_after_up);
        Policy_Land_ = Policy_Land_without_conflicts;
        
        Q_Nav_ = Q_Nav ; Q_Land_ = Q_updated; Q_Track_ = Q_Track; 
        R_Nav_ = R_Nav ; R_Land_ = Reward_updated; R_Track_ = R_Track; 
        MDP_adapted = 2; %Land
        case 3        
        %% wished_action = 3; 
            % 3: A23; Hovering & search of anthor potentiel target    
        Q_to_update = Q_Track;
        Reward      = R_Track; 
        Proba       = P_Track;
        statesinconflict = [4, 12];     % S4 wpF & S12 WPj
        % Track
        [policy_after_up, Q_updated, Reward_updated] = Resolve_Swarm_Conflicts(Q_to_update, Reward, Proba, ...
                                                                            discount, statesinconflict, wished_action);
        Policy_Land_without_conflicts = Global_Actions_MDP_Land(policy_after_up);
        Policy_Land_ = Policy_Land_without_conflicts;
        
        Q_Nav_ = Q_Nav ; Q_Land_ = Q_Land ; Q_Track_ = Q_updated; 
        R_Nav_ = R_Nav ; R_Land_ = R_Land ; R_Track_ = Reward_updated;         
            
    end
end