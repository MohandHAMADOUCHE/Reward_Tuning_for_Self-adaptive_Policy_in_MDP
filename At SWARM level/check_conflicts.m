function [Nav_in_conflit, Land_in_conflit, Track_in_conflit, statesinconflict_Nav, statesinconflict_Land, statesinconflict_Track] = ...
                                                check_conflicts(pol_1, pol_2, pol_3, constraint_table, Proba_sys, Proba_detect_obs, MDP_adapted)
%%intialisation 
nbr_State_Nav   = size(pol_1); 
nbr_State_Land  = size(pol_2); 
nbr_State_Track = size(pol_3); 

Nav_in_conflit  = false;
Land_in_conflit = false;
Track_in_conflit= false; 

statesinconflict_Nav   = false(nbr_State_Nav);
statesinconflict_Land  = false(nbr_State_Land);
statesinconflict_Track = false(nbr_State_Track);

nbr_constraint = size(constraint_table,1);

if (MDP_adapted == 1) % order (Nav) = 1
    if (Proba_sys >= 0.3)
        %order(Nav) = 1
        for i = 5 : nbr_State_Nav 
            for j = 5 : nbr_State_Track - 1
                for k = 1 : nbr_constraint
                    if (pol_3(j) == constraint_table(k,1)) && (pol_1(i) == constraint_table(k,2)) || ...
                        (pol_3(j) == constraint_table(k,2)) && (pol_1(i) == constraint_table(k,1))
                        statesinconflict_Track (j) = true;
                        if (Track_in_conflit ~= true); Track_in_conflit = true; end 
                    end
                end
            end
            for j = 5 : nbr_State_Land - 1
                for k = 1 : nbr_constraint
                    if (pol_2(j) == constraint_table(k,1)) && (pol_1(i) == constraint_table(k,2)) || ...
                        (pol_2(j) == constraint_table(k,2)) && (pol_1(i) == constraint_table(k,1))
                        statesinconflict_Land (j) = true;
                        if (Land_in_conflit ~= true); Land_in_conflit = true; end                    
                    end
                end
            end       
        end
    else
        %order(Land) = 1
        for i = 5 : nbr_State_Land - 1
            for j = 5 : nbr_State_Nav -1
                for k = 1 : nbr_constraint
                    if (pol_1(j) == constraint_table(k,1)) && (pol_2(i) == constraint_table(k,2)) || ...
                        (pol_1(j) == constraint_table(k,2)) && (pol_2(i) == constraint_table(k,1))
                        statesinconflict_Nav (j) = true;
                        if (Nav_in_conflit ~= true); Nav_in_conflit = true; end 
                    end
                end
            end
            for j = 5 : nbr_State_Track - 1
                for k = 1 : nbr_constraint
                    if (pol_3(j) == constraint_table(k,1)) && (pol_2(i) == constraint_table(k,2)) || ...
                        (pol_3(j) == constraint_table(k,2)) && (pol_2(i) == constraint_table(k,1))
                        statesinconflict_Track (j) = true;
                        if (Track_in_conflit ~= true); Track_in_conflit = true; end 
                    end
                end
            end     
        end        
    end
elseif (MDP_adapted == 2) % order (Land) = 1
    %order(Land) = 1
    for i = 5 : nbr_State_Land - 1
        for j = 5 : nbr_State_Nav -1 
            for k = 1 : nbr_constraint
                if (pol_1(j) == constraint_table(k,1)) && (pol_2(i) == constraint_table(k,2)) || ...
                    (pol_1(j) == constraint_table(k,2)) && (pol_2(i) == constraint_table(k,1))
                    statesinconflict_Nav (j) = true;
                    if (Nav_in_conflit ~= true); Nav_in_conflit = true; end 
                end
            end
        end
        for j = 5 : nbr_State_Track - 1
            for k = 1 : nbr_constraint
                if (pol_3(j) == constraint_table(k,1)) && (pol_2(i) == constraint_table(k,2)) || ...
                    (pol_3(j) == constraint_table(k,2)) && (pol_2(i) == constraint_table(k,1))
                    statesinconflict_Track (j) = true;
                    if (Track_in_conflit ~= true); Track_in_conflit = true; end 
                end
            end
        end     
    end     
else  % (MDP_modified == 3) % order (Track) = 1
    if (Proba_sys >= 0.3)
        if (Proba_detect_obs < 0.7)    %order(Track) = 1
            for i = 5 : nbr_State_Track - 1
                for j = 5 : nbr_State_Nav - 1
                    for k = 1 : nbr_constraint
                        if (pol_1(j) == constraint_table(k,1)) && (pol_3(i) == constraint_table(k,2)) || ...
                            (pol_1(j) == constraint_table(k,2)) && (pol_3(i) == constraint_table(k,1))
                            statesinconflict_Nav (j) = true;
                            if (Nav_in_conflit ~= true); Nav_in_conflit = true; end 
                        end
                    end
                end
                for j = 5 : nbr_State_Land - 1 
                    for k = 1 : nbr_constraint
                        if (pol_2(j) == constraint_table(k,1)) && (pol_3(i) == constraint_table(k,2)) || ...
                            (pol_2(j) == constraint_table(k,2)) && (pol_3(i) == constraint_table(k,1))
                            statesinconflict_Land (j) = true;
                            if (Land_in_conflit ~= true); Land_in_conflit = true; end                    
                        end
                    end
                end       
            end
        else
            %order(Nav) = 1
            for i = 5 : nbr_State_Nav - 1
                for j = 5 : nbr_State_Track - 1
                    for k = 1 : nbr_constraint
                        if (pol_3(j) == constraint_table(k,1)) && (pol_1(i) == constraint_table(k,2)) || ...
                            (pol_3(j) == constraint_table(k,2)) && (pol_1(i) == constraint_table(k,1))
                            statesinconflict_Track (j) = true;
                            if (Track_in_conflit ~= true); Track_in_conflit = true; end 
                        end
                    end
                end
                for j = 5 : nbr_State_Land - 1
                    for k = 1 : nbr_constraint
                        if (pol_2(j) == constraint_table(k,1)) && (pol_1(i) == constraint_table(k,2)) || ...
                            (pol_2(j) == constraint_table(k,2)) && (pol_1(i) == constraint_table(k,1))
                            statesinconflict_Land (j) = true;
                            if (Land_in_conflit ~= true); Land_in_conflit = true; end                    
                        end
                    end
                end       
            end
        end      
    else
        %order(Land) = 1
            for i = 5 : nbr_State_Land - 1 
                for j = 5 : nbr_State_Nav -1
                    for k = 1 : nbr_constraint
                        if (pol_1(j) == constraint_table(k,1)) && (pol_2(i) == constraint_table(k,2)) || ...
                            (pol_1(j) == constraint_table(k,2)) && (pol_2(i) == constraint_table(k,1))
                            statesinconflict_Nav (j) = true;
                            if (Nav_in_conflit ~= true); Nav_in_conflit = true; end 
                        end
                    end
                end
                for j = 5 : nbr_State_Track -1
                    for k = 1 : nbr_constraint
                        if (pol_3(j) == constraint_table(k,1)) && (pol_2(i) == constraint_table(k,2)) || ...
                            (pol_3(j) == constraint_table(k,2)) && (pol_2(i) == constraint_table(k,1))
                            statesinconflict_Track (j) = true;
                            if (Track_in_conflit ~= true); Track_in_conflit = true; end 
                        end
                    end
                end     
            end    
    end
end









