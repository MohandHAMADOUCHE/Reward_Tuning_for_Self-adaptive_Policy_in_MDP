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

function Policy_G1 = Global_Actions_MDP_Nav(Policy1)

%% adaptation des acttions locales par rapport aux actions de la mission globale
 for i = 1:size(Policy1)
    if (Policy1(i,1) == 5)
        Policy_G1(i,1) = Policy1(i,1) + 2; % =7 landing 
    elseif (Policy1(i,1) == 6)
        Policy_G1(i,1) = Policy1(i,1) + 4; % =10 retour à la base
    elseif ((Policy1(i,1) == 2) ||  (Policy1(i,1) == 3))
        Policy_G1(i,1) = Policy1(i,1) + 16; %= 18 SUIVI TRAJET + Detection OBSTACLE (LIDAR)
                                            %= 19 SUIVI TRAJET + DETECTION OBSTACLE WITH FUSION (US+IR)
    elseif ((Policy1(i,1) == 7) ||  (Policy1(i,1) == 8))
        Policy_G1(i,1) = Policy1(i,1) + 14; %= 21 Hovering & Detection OBSTACLE (A 21)
                                            %= 22 Hovering & DETECTION OBSTACLE WITH FUSION 
    elseif ((Policy1(i,1) == 9) || (i == 8) || (i == 9))
         Policy_G1(i,1) = 24; % NOP (A 24)
    else
        Policy_G1(i,1) = Policy1(i,1);
                    % = 1  TAKE-OFF (A1)
                    % = 4  AVOID OBSTACLE (A4)

    end
 end

end


