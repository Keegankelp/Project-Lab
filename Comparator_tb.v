`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2021 10:50:36 PM
// Design Name: 
// Module Name: Comparator_tb
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


module Comparator_tb(
    );
    reg IA;
    reg IB;
    reg resetBTN;
    reg clock;
    wire oc;
    
   Comparator UUT(IA, IB, resetBTN, clock, oc);
   
  
    
   
    initial begin
        IA = 0;
        IB = 0;
        resetBTN = 0;
        clock = 0;
        
        
        IA = 0;
        IB = 0;
        resetBTN = 0;
        
        #100
        
        IA = 1;
        IB = 0;
        resetBTN = 0;
        
        #100
        
        IA = 0;
        IB = 1;
        resetBTN = 0;
        
        #100
        
        IA = 0;
        IB = 0;
        resetBTN = 1;
        
        #100
        
        IA = 0;
        IB = 1;
        resetBTN = 0;
        
        
        end
        always begin
    
    #5 clock = ~clock;
    end
  
endmodule
