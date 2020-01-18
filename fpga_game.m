%#codegen

function [led_out] = fpga_game(button1,button2)

%States
Game_Wait = 0;
Game_Start = 1;
S3 = 2;
S4 = 3;
S5 = 4;

player1_score = 0;
player2_score = 0;

button1=0;
button2=0;


led_out = 0x01;




    function player1_score = add_point_to_player1()
    player1_score = player1_score+1;
    end

    function player2_score = add_point_to_player2()
        player2_score = player2_score+1;
    end

    function x = move_direction(a,flag)
        if (flag==1)
            x = bitsll(int64(a),1);
        else
            x = bitsrl(int64(a),1);
        end
    end

   



persistent current_state;
if isempty(current_state)
    current_state = Game_Wait;
end

switch (current_state)
    
    case Game_Wait
        if (button1==1 && button2==1)
            led_out=1;
            led_out=0;
            led_out=1;
            led_out=0;
            led_out=1;
            led_out=0;
            led_out=1;
            led_out=0;
            led_out=1;
            led_out=0;
            
            current_state = Game_Start;
        else
            current_state = Game_Wait;
        end
        
        
        
    case Game_Start
        if button1==1
            Direction = 0;
        elseif button2==1
            Direction = 1;
            
        current_state = S3;
        else
            current_state = Game_Start;
        end
        
    case S3
        Direction = prev_Direction;
        if Direction == 1
            game_tracker = 1;
        elseif Direction == 0
            game_tracker = 256;
            
            current_state = S4;
        end
        
        if player1_score >= 5
            current_state = S5;
        elseif player2_score >= 5
            current_state = S5;
        else
            current_state = S3;
        end
        
    case S4
        if Direction ~= prev_Direction
            prev_Direction = Direction;
        elseif (Direction == 1 && game_tracker < 512 && game_tracker > 1)
            add_point_to_player2;
            current_state = S3;
        elseif (Direction == 0 && game_tracker > 1 && game_tracker < 512)
            add_point_to_player1;
            current_state = S3;
        else
            led_out = game_tracker;
            if game_tracker > 256
                add_point_to_player1;
                current_state = S3;
            elseif game_tracker < 2
                add_point_to_player2;
                current_state = S3;
            end
        end
            
                game_tracker = move_direction(game_tracker,Direction);
                current_state = S4;
                
    case S5
        if player1_score >= 5
            led_out = 0x01;
        elseif player2_score >= 5
            led_out = 0x128;
        current_state = Game_Wait;
        
        end
        
    otherwise
        current_state = Game_Wait;
        
end
         
end
