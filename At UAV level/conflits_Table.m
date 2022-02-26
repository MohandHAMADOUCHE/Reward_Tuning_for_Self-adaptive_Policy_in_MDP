function [constraint_table] = conflits_Table

constraint_table = [ 
                     4  2; % avoid & next_WP
                     4  7; % avoid & land
                     4  8; % avoid & (replaning and land)
                     8 12; % (replaning and land) & traking_V0
                     8 13; % (replaning and land) & traking_V1
                     8 14; % (replaning and land) & traking_V2
                     8 15; % (replaning and land) & traking_V3
                     8 16; % (replaning and land) & traking_V4
                     8 17; % (replaning and land) & traking_V5
                     4 12; % avoid & traking_V0
                     4 13; % avoid & traking_V1
                     4 14; % avoid & traking_V2
                     4 15; % avoid & traking_V3
                     4 16; % avoid & traking_V4
                     4 17; % avoid & traking_V5
                    19  2; % avoid & next_WP
                    19  7; % avoid & land
                    19  8; % avoid & (replaning and land)
                    19 12; % avoid & traking_V0
                    19 13; % avoid & traking_V1
                    19 14; % avoid & traking_V2
                    19 15; % avoid & traking_V3
                    19 16; % avoid & traking_V4
                    19 17; % avoid & traking_V5 
                     2 12; % next_WP & traking_V0
                     2 13; % next_WP & traking_V1
                     2 14; % next_WP & traking_V2
                     2 15; % next_WP & traking_V3
                     2 16; % next_WP & traking_V4
                     2 17; % next_WP & traking_V5                    
                     7  2; % land & next_WP
                     7 12; % land & traking_V0
                     7 13; % land & traking_V1
                     7 14; % land & traking_V2
                     7 15; % land & traking_V3
                     7 16; % land & traking_V4
                     7 17; % land & traking_V5
                     7 10; % land & RTH                     
                    10 12; % RTH & traking_V0
                    10 13; % RTH & traking_V1
                    10 14; % RTH & traking_V2
                    10 15; % RTH & traking_V3
                    10 16; % RTH & traking_V4
                    10 17; % RTH & traking_V5


                     ];
end