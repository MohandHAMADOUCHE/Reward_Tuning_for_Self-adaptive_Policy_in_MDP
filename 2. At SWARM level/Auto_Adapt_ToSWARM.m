function [New_Policy_Nav_, New_Policy_Land_ , New_Policy_Track_,U1_Q_Nav_, U1_Q_Land_, U1_Q_Track_, ...
    U1_R_Nav_, U1_R_Land_, U1_R_Track_, MDP_adapted] = Auto_Adapt_ToSWARM (ID_UAV, Policy_Nav_, Policy_Land_ , ....
    Policy_Track_,Q_Nav, Q_Land, Q_Track, R_Nav, R_Land, R_Track, P_Nav, P_Land, P_Track, discount, signal_to_adapt, Policy_Type, Target, lack_Energy)
    
if lack_Energy == 0
    if signal_to_adapt == 1
            switch Policy_Type
                case 1 % Policy_Type = 1: RTH 
                    desired_action = 6;   % 6 : A10; RTH;
                    [New_Policy_Nav, New_Policy_Land , New_Policy_Track, Q_Nav_, Q_Land_, Q_Track_, R_Nav_, R_Land_, R_Track_, MDP_adapted] = modify_policy(Policy_Nav_, Policy_Land_, Policy_Track_, ...
                        Q_Nav, Q_Land, Q_Track, R_Nav, R_Land, R_Track, P_Nav, P_Land, P_Track, discount, desired_action);
                    New_Policy_Nav_ = New_Policy_Nav;
                    New_Policy_Land_ = New_Policy_Land;
                    New_Policy_Track_ = New_Policy_Track;
                    U1_Q_Nav_ = Q_Nav_ ; U1_Q_Land_ = Q_Land_; U1_Q_Track_ = Q_Track_;
                    U1_R_Nav_ = R_Nav_ ; U1_R_Land_ = R_Land_; U1_R_Track_ = R_Track_;

                case 2 % Policy_Type == 2 %  2: Landing
                    desired_action = 4;   % 4: A5; Search of "T" zone for landing 
                    [New_Policy_Nav, New_Policy_Land , New_Policy_Track, Q_Nav_, Q_Land_, Q_Track_, R_Nav_, R_Land_, R_Track_, MDP_adapted] = modify_policy(Policy_Nav_, Policy_Land_, Policy_Track_, ...
                        Q_Nav, Q_Land, Q_Track, R_Nav, R_Land, R_Track, P_Nav, P_Land, P_Track, discount, desired_action);
                    New_Policy_Nav_ = New_Policy_Nav;
                    New_Policy_Land_ = New_Policy_Land;
                    New_Policy_Track_ = New_Policy_Track;
                    U1_Q_Nav_ = Q_Nav_ ; U1_Q_Land_ = Q_Land_; U1_Q_Track_ = Q_Track_;
                    U1_R_Nav_ = R_Nav_ ; U1_R_Land_ = R_Land_; U1_R_Track_ = R_Track_;
                case 3 % 3: A23; Hovering & search of anthor potentiel target  
                    desired_action = 3;   % 3: A23; Hovering & search of anthor potentiel target  

                    % find  and/or switch to anathor target 
                    P_detect_target = 0;
                    target_t = 0;
                    nbr_target = size(Target,1);
                    for i=1:nbr_target 
                        if ((Target(i,8) == 0) && (Target(i,ID_UAV+1) > P_detect_target))
                            target_t = i;
                            P_detect_target = Target(i,ID_UAV+1);
                        end
                    end
                    Target(target_t,8) = ID_UAV;
                    target_to_track = target_t;

                    [New_Policy_Nav, New_Policy_Land , New_Policy_Track, Q_Nav_, Q_Land_, Q_Track_, R_Nav_, R_Land_, R_Track_,...
                        P_Nav, P_Land, P_Track, discount, Proba_sys, Proba_detect_obs] = Compute_UAV_Policies(ID_UAV, Target, target_to_track);
                    MDP_adapted = 3; 
                    New_Policy_Nav_ = New_Policy_Nav;
                    New_Policy_Land_ = New_Policy_Land;
                    New_Policy_Track_ = New_Policy_Track;
                    U1_Q_Nav_ = Q_Nav_ ; U1_Q_Land_ = Q_Land_; U1_Q_Track_ = Q_Track_;
                    U1_R_Nav_ = R_Nav_ ; U1_R_Land_ = R_Land_; U1_R_Track_ = R_Track_;
            end
        else   
            New_Policy_Nav_ = Policy_Nav_;
            New_Policy_Land_ = Policy_Land_;
            New_Policy_Track_ = Policy_Track_;
            U1_Q_Nav_ = Q_Nav ; U1_Q_Land_ = Q_Land; U1_Q_Track_ = Q_Track;
            U1_R_Nav_ = R_Nav ; U1_R_Land_ = R_Land; U1_R_Track_ = R_Track;
    end
else
    % MDP Landing receives the highest priority
    MDP_adapted = 2; 
    New_Policy_Nav_ = Policy_Nav_;
    New_Policy_Land_ = Policy_Land_;
    New_Policy_Track_ = Policy_Track_;
    U1_Q_Nav_ = Q_Nav ; U1_Q_Land_ = Q_Land; U1_Q_Track_ = Q_Track;
    U1_R_Nav_ = R_Nav ; U1_R_Land_ = R_Land; U1_R_Track_ = R_Track;
    
    % sending request to the edge for UAV replacement 
    % function to send the request and the target postion
    disp('sending UAV replacement request and target position')
end

