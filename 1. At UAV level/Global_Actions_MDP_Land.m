  % S1 base
  % S2 wp1
  % S3 wpI
  % S4 wpF
  % S5 zone_I T OK
  % S6 zone T NOK
  % S7 zone OK
  % S8 zone NOK 
  % S9 landing
  % S10 S_Collision
  % S11 zone T OK
  % S12 WPj

function Poliy_G2 = Global_Actions_MDP_Land(Policy2)
%% adaptation des acttions locales par rapport aux actions de la mission globale
 for i = 1:size(Policy2)
    if (Policy2(i,1) == 3 || Policy2(i,1) == 5)
        Poliy_G2(i,1) = Policy2(i,1) + 3;  % =6 recherche zone ATTERRISSAGE urgence (A6) ; = 8 REPLANNING + LANDING (A8)
    elseif (Policy2(i,1) == 4 || Policy2(i,1) == 6)
        Poliy_G2(i,1) = Policy2(i,1) + 1;  % =5 RECHERCHE DU "T" POUR ATTERRISSAGE (A5)   ; = 7 LANDING with camera (A7)
    elseif (Policy2(i,1) == 7)
    	Poliy_G2(i,1) = Policy2(i,1) + 13;
    elseif ((Policy2(i,1) == 8) || (i == 9) || (i == 10))
    	Poliy_G2(i,1) = 24;
    else       
        Poliy_G2(i,1) = Policy2(i,1);
                    % = 1  TAKE-OFF (A1)
                    % = 2  SUIVI TRAJET(A2)
    end
 end
end


