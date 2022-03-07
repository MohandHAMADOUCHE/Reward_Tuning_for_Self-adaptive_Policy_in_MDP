function [Target, nbr_target] = Targets_SWARM () 

%% Target characteristics
characteristics = 7;
nbr_target = 4;
 % Traget(:,1) -> ID_Target
 % Traget(:,2) -> P_detect_T_by_UAV_1
 % Traget(:,3) -> P_detect_T_by_UAV_2
 % Traget(:,3) -> P_detect_T_by_UAV_3
 % Traget(:,4) -> P_detect_T_by_UAV_4
 % Traget(:,5) -> P_detect_T_by_UAV_5
 % Traget(:,6) -> P_detect_T_by_UAV_6
 % Traget(:,7) -> ID_UAV_Tracker 
 Target(:,:) = zeros(nbr_target, characteristics + 1);
% for example: 
 Target(1,:) = [1, 0.6, 0.5, 0.4, 0.0, 0.1, 0.0, 0];
 Target(2,:) = [2, 0.6, 0.55, 0.3, 0.0, 0.0, 0.0, 6];
 Target(3,:) = [3, 0.1, 0.35, 0.45, 0.20, 0.1, 0.75, 0];
 Target(4,:) = [4, 0.46, 0.25, 0.24, 0.20, 0.1, 0.0, 0];
 
end 