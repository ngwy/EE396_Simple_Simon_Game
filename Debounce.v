`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2016 01:57:43 PM
// Design Name: 
// Module Name: Debounce
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

//module Debounce(
//    output reg out,
//    input clock,
//    input reset,
//    input button
//    );
    
////button_sync BS(button, clock, button_in);

//localparam N = 19;
//reg [18:0] count;
//wire tick;

//always @(posedge clock or posedge reset) begin
//    if(reset) count <= 0;
//    else count <= count + 1;
//    end
  
//assign tick = &count;

//localparam[2:0]                     //defining the various states to be used
//                zero = 3'b000,
//                high1 = 3'b001,
//                high2 = 3'b010,
//                high3 = 3'b011,
//                one = 3'b100,
//                low1 = 3'b101,
//                low2 = 3'b110,
//                low3 = 3'b111;
 
//reg [2:0]state_reg;
//reg [2:0]state_next;
                 
//always @ (posedge clock or posedge reset)     
//    begin
//        if (reset)
//            state_reg <= zero;
//        else
//            state_reg <= state_next;
//    end
     
 
//always @ (*)
//    begin
//        state_next <= state_reg;  // to make the current state the default state
//        out <= 1'b0;                    // default output low
         
//        case(state_reg)
//            zero:
//                if (button)                    //if button is detected go to next state high1
//                    state_next <= high1;
//            high1:
//                if (~button)                //while here if button goes back to zero then input is not yet stable and go back to state zero
//                    state_next <= zero;
//                else if (tick)                //but if button remains high even after 10 ms, go to next state high2.
//                    state_next <= high2;
//            high2:
//                if (~button)                //while here if button goes back to zero then input is not yet stable and go back to state zero
//                    state_next <= zero;
//                else if (tick)                //else if after 20ms (10ms + 10ms) button is still high go to high3
//                    state_next <= high3;
//            high3:
//                if (~button)                //while here if button goes back to zero then input is not yet stable and go back to state zero
//                    state_next <= zero;
//                else if (tick)                //and finally even after 30 ms input stays high then it is stable enough to be considered a valid input, go to state one
//                    state_next <= one;
             
//            one:                                //debouncing eliminated make output high, now here I'll check for bouncing when button is released
//                begin
//                    out <= 1'b1;
//                        if (~button)        //if button appears to be released go to next state low1
//                            state_next <=  low1;
//                end
//            low1:
//                if (button)                //while here if button goes back to high then input is not yet stable and go back to state one
//                    state_next <= one;
//                else if (tick)            //else if after 10ms it is still high go to next state low2
//                    state_next <= low2;
//            low2:
//                if (button)                //while here if button goes back to high then input is not yet stable and go back to state one
//                    state_next <= one;
//                else if (tick)            //else if after 20ms it is still high go to next state low3
//                    state_next <= low3;
//            low3:
//                if (button)                //while here if button goes back to high then input is not yet stable and go back to state one
//                    state_next <= one;
//                else if (tick)            //after 30 ms if button is low it has actually been released and bouncing eliminated, go back to zero state to wait for next input.
//                    state_next <= zero;
//            default state_next <= zero;
             
//        endcase
//    end
 
//endmodule

////////////////////////////////////////////////////////////////////////////////////
//module button_sync (
//	output out,
//	input clock,
//	input in
//);

//reg r1, r2, r3;

//always @(posedge clock) begin
//    r1 <= in;
//    r2 <= r1;
//    r3 <= r2;
//    end

//assign out = ~r3 & r2;

//endmodule
//module Debounce(
//    output reg PB_state,
//   // output PB_down;
//   // output PB_up;
//    input clk,
//    input PB
//);
//module Debounce(
//    output level_out,
//    input clk,
//    input n_reset,
//    input button_in
//    );
// parameter N = 11 ;      
 
//   reg  [N-1 : 0]  delaycount_reg;                     
//   reg  [N-1 : 0]  delaycount_next;
//   reg  DB_out;
     
//   reg DFF1, DFF2;                                 
//   wire q_add;                                     
//   wire q_reset;
 

//reg  delay_reg ; // Registers for detecting level change of DB_out
 
//       always @ ( posedge clk or negedge n_reset )
//       begin
//           if(n_reset ==  0) // At reset initialize FF and counter 
//               begin
//                   DFF1 <= 1'b0;
//                   DFF2 <= 1'b0;
//                   // For level change detection
//                   delay_reg  <=  1'b0;

//                   delaycount_reg <= { N {1'b0} };
//               end
//           else
//               begin
//                   DFF1 <= button_in;
//                   DFF2 <= DFF1;
//                   delaycount_reg <= delaycount_next;
                        
                    
                    
//                   delay_reg  <=  DB_out;// to detect level change
//               end
//       end
     
     
//   assign q_reset = (DFF1  ^ DFF2); // Ex OR button_in on conecutive clocks
//                                    // to detect level change 
                                      
//   assign  q_add = ~(delaycount_reg[N-1]); // Check count using MSB of counter         
     
 
//   always @ ( q_reset, q_add, delaycount_reg)
//       begin
//           case( {q_reset , q_add})
//               2'b00 :
//                       delaycount_next <= delaycount_reg;
//               2'b01 :
//                       delaycount_next <= delaycount_reg + 1;
//               default :
//               // In this case q_reset = 1 => change in level. Reset the counter 
//                       delaycount_next <= { N {1'b0} };
//           endcase   
//       end
     
     
//   always @ ( posedge clk )
//       begin
//           if(delaycount_reg[N-1] == 1'b1)
//                   DB_out <= DFF2;
//           else
//                   DB_out <= DB_out;
//       end
         
    
//   assign  level_out  =  (delay_reg)  &  (~DB_out); 
//// First use two flip-flops to synchronize the PB signal the "clk" clock domain
//reg PB_sync_0;  always @(posedge clk) PB_sync_0 <= ~PB;  // invert PB to make PB_sync_0 active high
//reg PB_sync_1;  always @(posedge clk) PB_sync_1 <= PB_sync_0;

//// Next declare a 16-bits counter
//reg [15:0] PB_cnt;

//// When the push-button is pushed or released, we increment the counter
//// The counter has to be maxed out before we decide that the push-button state has changed

//wire PB_idle = (PB_state==PB_sync_1);
//wire PB_cnt_max = &PB_cnt;  
module Debounce(
    output out,
    input clk,
    input n_reset,
    input button_in
    ); 
reg DB_out;
     
    /*
    Parameter N defines the debounce time. Assuming 50 KHz clock,
    the debounce time is 2^(11-1)/ 50 KHz = 20 ms
     
    For 50 MHz clock increase value of N accordingly to 21.
     
    */
    parameter N = 11 ;      
 
    reg  [N-1 : 0]  delaycount_reg;                     
    reg  [N-1 : 0]  delaycount_next;
     
    reg DFF1, DFF2;                                 
    wire q_add;                                     
    wire q_reset;
 
        always @ ( posedge clk )
        begin
            if(n_reset ==  1'b0) // At reset initialize FF and counter 
                begin
                    DFF1 <= 1'b0;
                    DFF2 <= 1'b0;
                    delaycount_reg <= { N {1'b0} };
                end
            else
                begin
                    DFF1 <= button_in;
                    DFF2 <= DFF1;
                    delaycount_reg <= delaycount_next;
                end
        end
     
     
    assign q_reset = (DFF1  ^ DFF2); // Ex OR button_in on conecutive clocks
                                     // to detect level change 
                                      
    assign  q_add = ~(delaycount_reg[N-1]); // Check count using MSB of counter         
     
 
    always @ ( q_reset, q_add, delaycount_reg)
        begin
            case( {q_reset , q_add})
                2'b00 :
                        delaycount_next <= delaycount_reg;
                2'b01 :
                        delaycount_next <= delaycount_reg + 1;
                default :
                // In this case q_reset = 1 => change in level. Reset the counter 
                        delaycount_next <= { N {1'b0} };
            endcase    
        end
     
     
    always @ ( posedge clk )
        begin
            if(delaycount_reg[N-1] == 1'b1)
                    DB_out <= DFF2;
            else
                    DB_out <= DB_out;
        end
assign out  = DB_out;         
endmodule
