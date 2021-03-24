`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2021 12:42:16 AM
// Design Name: 
// Module Name: Division
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


module Division(
 input [Width-1:0] Color,
    input [Width-1:0] Clear,
    output [Width-1:0] Res,
    output [Width-1:0] cc);

    //input and output ports.
   
    //internal variables    
    wire [Width:0] Colorx;
    wire [Width:0] shift3;
    wire [Width:0] shift2;
    wire [Width:0] shift1;
    
    
    reg [Width-1:0] Res = 0;
    reg [Width-1:0] a1 = 0;
    reg [Width-1:0] b1 = 0;
    reg [Width:0] p1 = 0;   
    integer i = 0;
localparam  Width = 15;

assign shift3 = Color << 6;
assign shift2 = Color << 5;
assign shift1 = Color << 2;
assign Colorx = shift3 + shift2 + shift1;
assign cc = Colorx;
    always@ (cc or Clear)
    begin
        //initialize the variables.
        a1 = cc;
        b1 = Clear;
        p1= 0;
        for(i=0;i < Width;i=i+1)    begin //start the for loop
            p1 = {p1[Width-2:0],a1[Width-1]};
            a1[Width-1:1] = a1[Width-2:0];
            p1 = p1-b1;
            if(p1[Width-1] == 1)    begin
                a1[0] = 0;
                p1 = p1 + b1;   end
            else
                a1[0] = 1;
        end
        Res = a1;   
    end 

endmodule
