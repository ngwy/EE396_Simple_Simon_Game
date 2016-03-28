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
    output [3:0]    an,
    output [6:0]    seg,
    output [15:0]   led,
    input  [1:0]    sw,
    input           clk,
    input           btnR,     // Right button
    input           btnL,     // Left button
    input           btnC,     // Start button
    input           btnU      // Reset button
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


///////////////////////// Simon with 1 bit
wire [7:0]  ran_gen;
wire [1:0]  led_pressed;
wire [1:0]  led_flash;
wire [3:0]  an_stat;
wire [6:0]  seg_stat;
wire        right_pressed;
wire        left_pressed;
wire        center_pressed;
wire        times_up;
wire        correct_bit;
wire        pressed;
wire        flash_done;

reg  [1:0]  state;
reg  [1:0]  next_state;
reg  [15:0] led_reg;
reg  [7:0]  bit_gen;
reg         resetC;
reg         resetR;
reg         resetL;
reg         ran_enable;
reg         timer_start;
reg         times_up_reg;
reg         correct;
reg         bit_enable;
reg         display_start;
reg         display_finish_reg;
reg         flash_enable;
reg         flash_done_reg;

assign      led = led_reg;
assign      an  = an_stat;
assign      seg = seg_stat;

Debounce                    DR(right_pressed, clk, resetR, btnR);
Debounce                    DL(left_pressed, clk, resetL, btnL);
Debounce                    DC(center_pressed, clk, resetC, btnC);

Random_number_generator     RNG(ran_gen, clk, ran_enable, center_pressed);
Timer_check                 Timer(times_up, clk, timer_start);
Checking_1bit               Check(correct_bit, led_pressed ,clk, right_pressed, left_pressed, bit_enable, bit_gen[0]);
Display_message             DM(an_stat, seg_stat, display_finish, clk, display_start, correct);
Display_flash_bits          DB(led_flash, flash_done, clk, flash_enable, 0, bit_gen);

initial begin
    next_state          <= 0;
    bit_gen             <= 0;
    bit_enable          <= 0;
    resetC              <= 0;
    resetR              <= 0;
    resetL              <= 0; 
    ran_enable          <= 0;
    timer_start         <= 0;
    times_up_reg        <= 1; 
    correct             <= 0;
    display_start       <= 0;
    display_finish_reg  <= 0;
    flash_enable        <= 0;
    flash_done_reg      <= 0;
    end
    
    
always @(posedge clk) begin
    state               <= next_state;
    led_reg [15:8]      <= ran_gen;
    led_reg [5:4]       <= state;
    led_reg [3:2]       <= led_flash; 
    led_reg [1:0]       <= led_pressed;
    
        case(state)
            0: begin
                bit_gen             <= 0;
                timer_start         <= 0;
                times_up_reg        <= 1;
                correct             <= 0;
                bit_enable          <= 0;
                resetR              <= 0;
                resetL              <= 0;
                display_start       <= 0;
                display_finish_reg  <= 0;
                flash_enable        <= 0;
                flash_done_reg      <= 0;
                resetC              <= 1;
                ran_enable          <= 1;
               
                if (center_pressed == 1) begin
                    bit_gen         <= ran_gen;
                    ran_enable      <= 0;
                    resetC          <= 0;
                    next_state      <= 1;
                    end
                else 
                    next_state      <= 0;
                end
            1: begin
                resetR              <= 1;
                resetL              <= 1;
                flash_done_reg      <= flash_done;
                flash_enable        <= 1;
                if (flash_done_reg == 1) begin
                    flash_enable    <= 0;
                    next_state      <= 2;
                    end
                else 
                    next_state      <= 1;               
                end
            2: begin
                timer_start         <= 1;
                bit_enable          <= 1;
                times_up_reg        <= times_up;
                if ((right_pressed == 1 || left_pressed == 1) && (times_up_reg == 1)) begin
                    correct         <= correct_bit;
                    timer_start     <= 0;
                    resetR          <= 0;
                    resetL          <= 0;
                    bit_enable      <= 0;
                    next_state      <= 3;
                    end
                else if (times_up_reg == 0) begin     // Time is up
                    timer_start     <= 0;
                    correct         <= 0;
                    resetR          <= 0;
                    resetL          <= 0;
                    bit_enable      <= 0;
                    next_state      <= 3;
                    end
                else 
                    next_state      <= 2;
                end   
            3: begin  
                display_start       <= 1;
                display_finish_reg  <= display_finish;
                if (display_finish_reg == 1)  begin
                    display_start   <= 0;
                    next_state      <= 0;
                    end
                else   
                    next_state      <= 3;
                end
            endcase
  
    end             
                
            
/////////////////////// Test Debounce ////////////////////////////////////
//wire        up_pressed;
//wire        reset;

//reg  [3:0]  led_reg;

//assign      led = led_reg;

//initial     led_reg <= 0;

//Debounce    DB(up_pressed, clk, 1, btnU);
//Debounce    DR(reset, clk, 1, btnC);

//always @(posedge clk) begin
//    if (up_pressed == 1) begin
//        led_reg     <=  led_reg + 1;
//        end
//    if (reset == 1) 
//        led_reg     <= 0;
//    end

/////////////////////// Test Timer_check ///////////////////////////////////
//wire        times_up;

//reg  [1:0]  led_reg;
//reg         times_up_reg;
//reg         timer_start;

//assign      led = led_reg;

//Timer_check TM(times_up, clk, sw[0]);

//always @(posedge clk) begin
//    times_up_reg        <=      times_up;
//    if (sw[0] == 1) begin       // If timer is enabled
//        if (times_up_reg == 1)  led_reg <= 0'b11;   // 1 when time is not up
//        else                    led_reg <= 0'b01;
//        end
//    else                        led_reg <= 0'b00;
//    end 
 
///////////////////////////// Test Display_flash_bits //////////////////////////////////////////////////
//wire [3:0]  led_flash;
//wire        flash_done;

//reg  [5:0]  led_reg;
//reg         display_done;

//assign      led = led_reg;

//Display_flash_bits  DB(led_flash, flash_done, clk, sw[0], 7, 8'b01010011);

//always @(posedge clk) begin
//    led_reg[3:0]    <=      led_flash;
//    display_done    <=      flash_done;
//    if (display_done == 1)  led_reg[5:4] <= 0'b01;
//    else                    led_reg[5:4] <= 0'b10;
//    end
    
/////////////////// Test Display_message /////////////////////////////////////////
//wire [3:0]  an_stat;
//wire [6:0]  seg_stat;
//wire        display_finish;

//reg  [1:0]  led_reg;
//reg         display_finish_reg;
 
//assign      an  = an_stat;
//assign      seg = seg_stat;
//assign      led = led_reg;

//Display_message     DM(an_stat, seg_stat, display_finish, clk, sw[1] ,sw[0]);

//always @(posedge clk) begin
//    display_finish_reg      <=          display_finish;
//    if (display_finish_reg == 1)        led_reg <= 0'b01;
//    else if (display_finish_reg == 0)   led_reg <= 0'b10;
//    end

//////////////////// Test RNG /////////////////////////////////////////
//wire [7:0]  bit_gen;
//wire        center_pressed;

//reg  [7:0]  bit_reg;
//reg  [7:0]  led_reg;

//assign      led = led_reg;

//Debounce                DC(center_pressed, clk, btnC);
//Random_number_generator RNG(bit_gen, clk, 1, btnC);

//always @(posedge clk) begin
//    bit_reg         <=      bit_gen;
//    if (bit_reg[7] == 1)    led_reg[7] <= 1;
//    else                    led_reg[7] <= 0;
//    if (bit_reg[6] == 1)    led_reg[6] <= 1;
//    else                    led_reg[6] <= 0;
//    if (bit_reg[5] == 1)    led_reg[5] <= 1;
//    else                    led_reg[5] <= 0;
//    if (bit_reg[4] == 1)    led_reg[4] <= 1;
//    else                    led_reg[4] <= 0;
//    if(bit_reg[3] == 1)     led_reg[3] <= 1;
//    else                    led_reg[3] <= 0;
//    if (bit_reg[2] == 1)    led_reg[2] <= 1;
//    else                    led_reg[2] <= 0;
//    if (bit_reg[1] == 1)    led_reg[1] <= 1;
//    else                    led_reg[1] <= 0;
//    if (bit_reg[0] == 1)    led_reg[0] <= 1;
//    else                    led_reg[0] <= 0;
//    end

///////////////////////////// Test Checking_1bit ///////////////////////////////////////////////
//wire [1:0]      led_pressed;
//wire            right_pressed;
//wire            left_pressed;
//wire            correct;

//reg  [3:0]      led_reg;
//reg             correct_reg;

//assign          led = led_reg;

//Debounce        DR(right_pressed, clk, 1, btnR);
//Debounce        DL(left_pressed, clk, 1, btnL);
//Checking_1bit   Check(correct, led_pressed, clk, right_pressed, left_pressed, sw[0], 1);

//always @(posedge clk) begin
//    led_reg [1:0]           <= led_pressed;
//    correct_reg             <= correct;
//    if (correct_reg == 1)   led_reg[3:2] <= 0'b01;
//    else                    led_reg[3:2] <= 0'b10;
//    end
    
//////////////////////////// Test Checking_nbit 
//wire [1:0]  led_pressed;
//wire [3:0]  index;
//wire        correct;
//wire        done;
//wire        right_pressed;
//wire        left_pressed;

//reg  [7:0]  led_reg;
//reg         correct_reg;
//reg         done_reg;
//reg         resetR;
//reg         resetL;

//assign      led = led_reg;

//Debounce        DR(right_pressed, clk, resetR, btnR);
//Debounce        DL(left_pressed, clk, resetL, btnL);
//Checking_nbits  Checkn(correct, done, led_pressed, index, clk, right_pressed, left_pressed, sw[0], 3, 8'b01100110);

//initial begin
//    resetR  <= 0;
//    resetL  <= 0;
//    end
    
//always @(posedge clk) begin
//    resetR          <= 1;
//    resetL          <= 1;
//    correct_reg     <= correct;
//    done_reg        <= done;
//    led_reg[1:0]    <= led_pressed;
//    led_reg[5:2]    <= index;
//    if(correct_reg == 1)    led_reg[6]  <= 1;
//    else                    led_reg[6]  <= 0;
//    if(done_reg == 1)       led_reg[7]  <= 1;
//    else                    led_reg[7]  <= 0;
//    end


    
endmodule
