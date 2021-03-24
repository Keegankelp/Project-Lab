`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2021 12:46:06 AM
// Design Name: 
// Module Name: Division_tb
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


module Division_tb( 


    );
    parameter Width = 15;
    // Inputs
    reg [Width-1:0] Color;
    reg [Width-1:0] Clear;
    // Outputs
    wire [Width-1:0] Res;
    wire [Width-1:0] cc;
    // Instantiate the division module (UUT)
   Division uut(Color,Clear,Res,cc);
     initial begin
        // Initialize Inputs and wait for 100 ns
        Color = 0;  Clear = 0;  #100;  //Undefined inputs
        //Apply each set of inputs and wait for 100 ns.
        Color = 100;    Clear = 130; #100;
        Color = 200;    Clear = 215; #100;
        Color = 90; Clear = 120;  #100;
        Color = 70; Clear = 89; #100;
        Color = 16; Clear = 173;  #100;
        Color = 255;    Clear = 294;  #100;
    end
      
endmodule
