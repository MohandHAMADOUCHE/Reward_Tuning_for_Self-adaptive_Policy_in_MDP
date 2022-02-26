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
function [a] = actions_navigation(s)
    switch s
        case 1      % s_base 
            nbr_Ac = 1;    % A1
        case 2       % wp1
            nbr_Ac = 2;   %A18, A19
        case 3       % wpi
            nbr_Ac = 4;   %A18, A19, A10, A7
        case 4      % wpF
            nbr_Ac = 4;    %A21, A22, A7, A10
        case 5      % OBSTACLE_det
            nbr_Ac = 1;  % A4, NOP   
        case 6      % S_fusion
            nbr_Ac = 1;    % A19, NOP
        case 7      % WP_avoidance   
            nbr_Ac = 1;     % A4, NOP
        case 8      % S_landing
            nbr_Ac = 1;  % NOP   
        case 9      % S_Collision
            nbr_Ac = 1;    % NOP
        case 10     % WPj
            nbr_Ac = 2;    %A21, A22                                           
    end
            
	ac = randi([1,nbr_Ac]);
	
    switch s
        case 1      % s_base 
            a = 1;    % A1
        case 2       % wp1
            if ac == 1
                a = 2; %A18
            else
                a = 3; %A19
            end
        case 3       % wpi
            if ac == 1
                a = 2; %A18
            elseif ac == 2
                a = 3; %A19
            elseif ac == 3
                a = 5; % A7
            else
               a = 6; % A10
            end  
        case 4      % wpF
            if ac == 1
                a = 7; %A21
            elseif ac == 2
                a = 8; % A22
            elseif ac == 3
                a = 5; % A7
            else
               a = 6; % A10
            end                     
        case 5      % OBSTACLE_det
            if ac == 1
                a = 4; %A4
            else
                a = 9; %NOP
            end                    
        case 6      % S_fusion
            if ac == 1
                a = 3; % A19
            else
                a = 9; %NOP
            end                     
        case 7      % WP_avoidance   
            if ac == 1
                a = 4; % A4
            else
                a = 9; %NOP
            end                    
        case 8      % S_landing
            a = 1;  % NOP   
        case 9      % S_Collision
            a = 1;    % NOP
        case 10     % WPj
            if ac == 1
                a = 7; % A21
            else
                a = 8; %22
            end                    
    end
end