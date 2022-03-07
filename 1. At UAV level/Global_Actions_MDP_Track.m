
  % S1 base
  % S2 wp1
  % S3 wpI
  % S4 wpF
  % S5 target = cible detectee
  % S6 S5V0
  % S7 S5V1
  % S8 S5V2
  % S9 S5V3
  % S10 S5V4
  % S11 S5V5
  % S12 S_landing 
  % S13 S_WPj
  
function Policy_G3 = Global_Actions_MDP_Track(Policy3)

%% adaptation des acttions locales par rapport aux actions de la mission globale
 for i = 1:size(Policy3)
    if (Policy3(i,1) == 3) 
        Policy_G3(i,1) = Policy3(i,1) + 20; % = 23  hovering & detection de cible  
    elseif ((Policy3(i,1) > 3) && (Policy3(i,1) < 10))
        Policy_G3(i,1) = Policy3(i,1) + 8; 
                    % = 12  Tracking V0 (A12)
                    % = 13  Tracking V1 (A13)
                    % = 14  Tracking V2 (A14)
                    % = 15  Tracking V3 (A15)
                    % = 16  Tracking V4 (A16)
                    % = 17  Tracking V5 (A17)
    elseif ((Policy3(i,1) == 11) || (i == 12))
    	Policy_G3(i,1) = 24; % NOP (A 24)
    else      
        Policy_G3(i,1) = Policy3(i,1); 
                    % = 1  TAKE-OFF (A1)
                    % = 2  SUIVI TRAJET  (A2)
                    % = 10 retour à la base  (A10)
    end
 end

end