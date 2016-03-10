`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2016 10:21:12 PM
// Design Name: 
// Module Name: Simon
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Simon(
    output [3:0] an,
    output [6:0] seg,
    output [7:0] led,
    input [1:0] sw,
    input clk,
    input btnR,     // Right button
    input btnL,     // Left button
    input btnC,     // Start button
    input btnU      // Reset button
    );

////-----------Generate Random Sequence--------------
//wire [7:0] bit_gen;
//reg [7:0] bit_gen_reg;
//reg ran_gen_enable;
//Random_number_generator RNG(bit_gen, clk, ran_gen_enable, start);

////------------------Flash bit sequence---------------------
//wire [3:0] led_stat;
//reg [3:0] led_reg;
//reg [2:0] round;
//reg led_start;

//Display_flash_bits DB(led_stat, clk, led_start, round, bit_gen);

////----------Get and Check Input--------------------
//wire correct_bit;
//reg correct_bit_reg;

//Checking_1bit Check(correct_bit, led_stat, clk, right_button, left_button, bit_gen[round]);

////----------Display Message-----------
//wire [3:0] an_stat;
//wire [6:0] seg_stat;
//reg message_start;
//reg win;

//Display_message DM(an_stat, seg_stat, clk, message_start, win);

////---------------Output Assignments-----------------
//assign an = an_stat;
//assign sed = seg_stat;
//assign led = led_stat;

//initial begin
//    round <= 0;     // On the first round of the game
//    state <= 0;    // Start state of the game
//    led_reg = 0;
//    bit_gen_reg <= 0;
//    end

//always @(clk) begin
//    state <= next_state;
//    end
    
//always @(*) begin
//    if(~btnU) begin
//        case(state)
//            0: begin    // Start state of the game
//                if(btnC == 1) begin
//                    bit_gen_reg <= 8'b01101010;
//                    next_state <= 1;
//                    end
//                else next_state <= 0;
//                end
            
//            1: begin    // Display bits
//                //call timer after displaying bits
//                next_state <= 2;
//                end
            
//            2: begin    // Get input and check input
//                if(btnL || btnC) begin
//                    correct_reg <= correct_bit;
//                    next_state <= 3;
//                    end
//                else next_state <= 2;
//                end
            
//            3: begin    // Display result message
//                if(correct_reg==1)  led_reg <= 4'b0100;
//                else led_reg <= 4'b1000;
//                //next_state <= 0;
//                end
//            endcase
//        end
//    else next_state <= 0;           
// end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////// Simon with 1 bit
//reg [1:0] state;
//reg [1:0] next_state;
//reg [7:0] led_reg;
//reg correct;
//reg checking_done_reg;
//reg display_start;
//reg display_finish_reg;
//wire checking_done;
//wire correct_bit;
//wire[1:0] led_state;
//wire [3:0] an_stat;
//wire [6:0] seg_stat;
//wire [7:0] ran_gen;
//reg [7:0] bit_gen;
//reg ran_enable;
//reg flash_enable;
//wire flash_done;
//reg flash_done_reg;
//wire [1:0] led_flash;
//wire right_pressed;
//wire left_pressed;
//wire center_pressed;
//wire up_pressed;
//reg reset;
//assign led = led_reg;
//assign an = an_stat;
//assign seg = seg_stat;

//Debounce DR(right_pressed, clk, reset, btnR);
//Debounce DL(left_pressed, clk, reset, btnL);
//Debounce DC(center_pressed, clk, reset, btnC);
//Debounce DU(up_pressed, clk, reset, btnU);

//Random_number_generator RNG(ran_gen, clk, ran_enable, center_pressed);
//Checking_1bit Check(correct_bit, checking_done, led_state ,clk, right_pressed, left_pressed, bit_gen[3]);
//Display_message DM(an_stat, seg_stat, display_finish, clk, display_start , correct);
//Display_flash_bits DB(led_flash, flash_done, clk, flash_enable, 0, bit_gen);

//initial begin
//    next_state <= 0;
//    bit_gen <= 0;
//    correct <= 0;
//display_start <= 0;
//ran_enable <= 0;
//flash_enable <= 0;
//checking_done_reg <= 0;
//display_finish_reg <= 0;
//flash_done_reg <= 0;
//reset <= 1;
//    end
    
//always @(posedge clk) begin
//    state <= next_state;
//    end
//always @(posedge clk) begin
//    led_reg [5:4] = state;
//     led_reg[3:2] = led_flash; 
//    led_reg[1:0] = led_state;
//    if(up_pressed == 0) begin
//        reset <= 0;
//        case(state)
//            0: begin
//             bit_gen <= 0;
//            correct <= 0;
//        display_start <= 0;
//        flash_enable <= 0;
//        checking_done_reg <= 0;
//        display_finish_reg <= 0;
//        flash_done_reg <= 0;
//                ran_enable = 1;
//                if(center_presssed ==1) begin
//                   bit_gen = ran_gen;
//                   ran_enable = 0;
//                   next_state = 1;
//                   end
//                else next_state <= 0;
//                end
//            1: begin
//               flash_enable = 1;
//               flash_done_reg = flash_done;
//                if(flash_done_reg == 1) begin
//                    flash_enable = 0;
//                    next_state = 2;
//                    end
//                else next_state = 1;               
//                end
//            2: begin
//                    if(right_pressed||left_pressed) begin
//                    correct = correct_bit;
//                    checking_done_reg = checking_done;
//                    end
//                    else next_state <= 2;
//               if(checking_done_reg == 0) next_state <= 2;
//               else next_state <= 3;
//               end   
//            3: begin  
//               display_start = 1;
//               display_finish_reg = display_finish;
//               if(display_finish_reg == 1)  begin
//                    display_start <= 0;
//                    next_state = 0;
//                    end
//               else next_state = 3;
//               end
//            endcase
//        end
//    else begin
//    next_state <= 0;
//    bit_gen <= 0;
//    correct <= 0;
//display_start <= 0;
//ran_enable <= 0;
//flash_enable <= 0;
//checking_done_reg <= 0;
//display_finish_reg <= 0;
//flash_done_reg <= 0;
//reset <= 1;
//        end
//    end             
                
            
                 
/////////////////////// Testing timer ///////////////////////////////////
//wire times_up;
//reg times_up_reg;
//reg timer_start;
//reg [3:0] led_reg;
//assign led = led_reg;
//initial timer_start <= 1;
//Timer_check TM(times_up, clk, sw[0]);

//always @(posedge clk) begin
//    times_up_reg <= times_up;
//    if(times_up_reg==1) begin
//        if(sw[0] == 1) led_reg[1:0]<=3;
//        else led_reg[1:0] <= 1;
//        end   
//    else if(times_up_reg ==0) begin
//        if(sw[0] == 1)     
//            led_reg[1:0] <= 2;
//        else led_reg[1:0] <= 0;
//        end
//    end       

///////////////////////////// Testing Display bits //////////////////////////////////////////////////
//wire done;
//wire [3:0] led_flash;
//reg [5:0] led_reg;
//reg bit_done;
//assign led = led_reg;

//Display_flash_bits DB(led_flash, done, clk, sw[0], 7, 8'b01010011);

//always @(posedge clk) begin
//    led_reg[3:0] <= led_flash;
//    bit_done <= done;
//    if(bit_done == 1)   led_reg[5:4] = 1;
//    else led_reg[5:4] = 2;
//    end
    
///////////////////// Testing Display_message /////////////////////////////////////////
//wire [3:0] an_stat;
//wire [6:0] seg_stat;
//wire display_finish;
//reg display_finish_reg;
//reg [3:0] led_reg;
 
//assign an = an_stat;
//assign seg = seg_stat;
//assign led = led_reg;

//Display_message DM(an_stat, seg_stat, display_finish, clk, sw[1] ,sw[0]);

//always@(posedge clk) begin
//    display_finish_reg <= display_finish;
//    if(display_finish_reg == 1)     // If finish displaying message
//        led_reg[0] <= 1;
//    else if (display_finish_reg == 0)
//        led_reg[0]<= 0;
//    end

//////////////////// Testing RNG /////////////////////////////////////////
//wire [7:0] bit_gen;
//reg [7:0] bit_reg;
//reg [7:0] led_reg;

//assign led = led_reg;

//Random_number_generator RNG(bit_gen, clk, 1, button_debounced);

//always @(posedge clk) begin
//    bit_reg <= bit_gen;
//    if(bit_reg[7] ==1)  led_reg[7] <= 1;
//    else led_reg[7] <= 0;
//        if(bit_reg[6] ==1)  led_reg[6] <= 1;
//    else led_reg[6] <= 0;
//        if(bit_reg[5] ==1)  led_reg[5] <= 1;
//    else led_reg[5] <= 0;
//        if(bit_reg[4] ==1)  led_reg[4] <= 1;
//    else led_reg[4] <= 0;
//        if(bit_reg[3] ==1)  led_reg[3] <= 1;
//    else led_reg[3] <= 0;
//        if(bit_reg[2] ==1)  led_reg[2] <= 1;
//    else led_reg[2] <= 0;
//        if(bit_reg[1] ==1)  led_reg[1] <= 1;
//    else led_reg[1] <= 0;
//        if(bit_reg[0] ==1)  led_reg[0] <= 1;
//    else led_reg[0] <= 0;
//end


//////////////////////////// Testing Checking 1 bit
//wire right_pressed;
//wire left_pressed;
//wire [1:0] led_presssed;
//wire correct;
//wire checking_done;
//reg reset;
//reg correct_reg;
//reg checking_done_reg;
//reg [7:0] led_reg;

//Debounce DR(right_pressed, clk, reset, btnR);
//Debounce DL(left_pressed, clk, reset, btnL);
//Checking_1bit(correct, checking_done, led_pressed, clk, right_pressed, left_pressed, 1);

//assign led = led_reg;

//initial begin
//    reset <= 1;
//    checking_done_reg <= 0;
//    end
//always @(posedge clk) begin
//    correct_reg <= correct;
//    checking_done_reg <= checking_done;
//    led_reg[1:0] <= led_pressed;
    
//    if(correct_reg == 1)    led_reg[3:2] = 1;
//    else led_reg[3:2] = 2;
//    if(checking_done_reg == 1)  led_reg[5:4] = 1;
//    else led_reg[5:4] = 2;
    
//    end
    
//////////////////////////// Testing Checking n bit 
wire right_pressed;
wire left_pressed;
wire correct;
wire done;
wire [1:0] led_pressed;
reg [7:0] led_reg;
reg correct_reg;
reg done_reg;
reg reset;
wire [3:0] index;

assign led = led_reg;

initial begin
    led_reg <= 0;
    correct_reg <= 0;
    done_reg <= 0;
    reset <= 1;
    end

Debounce DR(right_pressed, clk, reset, btnR);
Debounce DL(left_pressed, clk, reset, btnL);
    
Checking_nbits Checkn(correct, done, led_pressed, index, clk, right_pressed, left_pressed, sw[0], 7, 8'b01100110);

always @(posedge clk) begin
    reset = 0;
    correct_reg = correct;
    done_reg = done;
    led_reg[1:0] <= led_pressed;
    led_reg[5:2] <= index;
    if(correct_reg == 1)    led_reg[6] = 1;
    else led_reg[6] =0;
    if(done_reg == 1)   led_reg[7] = 1;
    else led_reg[7] = 0;
    end


    
endmodule
