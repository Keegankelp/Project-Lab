`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2021 10:24:18 PM
// Design Name: 
// Module Name: State_Machine
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


module State_Machine(
input clock,
input IRR,
input IRL,
input Blue,
input Red,
input Green,
input reset
    );
    
    reg out [2:0];
    
    parameter S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8;
    reg state [2:0];
    


// The following contains SystemVerilog constructs and should not be used if using a tool that does not support this standard

//   enum logic [2:0] {S1 = 3'b000, // stop
//                     S2 = 3'b001, // search
//                     S3 = 3'b010, // left turn
//                     S4 = 3'b011, // right turn
//                     S5 = 3'b100, // red
//                     S6 = 3'b101, // blue
//                     S7 = 3'b110, // green
//                     S8 = 3'b111} // pause
//                     state;

always @ (state) begin
case (state)
S1:
   out = 2'b000;
S2:
   out = 2'b001;
S3:
   out = 2'b010;
S4:
   out = 2'b011;
S5:
   out = 2'b100;
S6:
   out = 2'b101;
S7:
   out = 2'b110;
S8:
   out = 2'b111;
default:
   out = 2'b000;
endcase
end
   always @(posedge clock or posedge reset)
      if (reset)
         state <= S1;
      else
         case (state)
             S1 : begin
               if (Go)
                  state <= S2; // start searching
             //  else if (<condition>)
               //   <state> <= <next_state>;
               else
                  state <= S1; // stay stopped
            end
            S2 : begin 
            // may need to set Fturns and Fcolors to zero here
               if (IRR)
                  state <= S3; // start turning left
               else if (IRL)
                  state <= S4; // start turning right
                    else if (Red)
                    state <= S5; // stop and display red
                        else if (Blue)
                        state <= S6; // stop and display blue
                            else if (Green)
                            state <= S7; // stop and display green
                                else if (Pause)
                                state <= S8; // pause
               else
                  state <= S2; // continue turning
            end
            S3 : begin
               if (FturnL)
                  state <= S2; //go to search
              // else if (<condition>)
               //   <state> <= <next_state>;
               else
                  state <= S2; //continue turning
            end
            S4 : begin
               if (FturnR)
                  state <= S2; // start searching
               //else if (<condition>)
               //   <state> <= <next_state>;
               else
                  state <= S4; // continue turning
            end
            S5 : begin
               if (Fred)
                  state <= S2; // start searching
              // else if (<condition>)
              //    <state> <= <next_state>;
               else
                  state <= S5; // continue displaying red
            end
            S6 : begin
               if (Fblue)
                  state <= S2; // start searching
              // else if (<condition>)
               //   <state> <= <next_state>;
               else
                  state <= S6; // continue displaying blue
            end
            S7 : begin
               if (Fgrean)
                  state <= S2; // start searching
              // else if (<condition>)
              //    <state> <= <next_state>;
               else
                  state <= S7; // continue displaying green
            end
            S8 : begin
               if (Go)
                  state <= S2; // start searching
             //  else if (<condition>)
             //     <state> <= <next_state>;
               else
                  state <= S8; // stay paused
            end
            default : begin  // Fault Recovery
               state <= S1;
            end
         endcase
endmodule
  // assign <output1> = <logic_equation_based_on_states_and_inputs>;
  // assign <output2> = <logic_equation_based_on_states_and_inputs>;
   // Add other output equations as necessary
							
			


















