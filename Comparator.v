`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2021 07:56:02 PM
// Design Name: 
// Module Name: Comparator
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


module Comparator(
    input IA, IB,   // input signals from motor A and motor B
    input resetBTN,  // reset button
    input clock,
    output oc      // overcurrent

    );
    
    reg oc_temp;
    reg [20:0] count;
    initial begin
        oc_temp = 0;
        count = 0;
    end
    always@(posedge clock) begin
        if (IA | IB) begin
        count <= count + 1;
    
        end
        else begin 
        count = 0;
        end
    end
    
    
    always@(*)begin
       
     if(~oc_temp) begin
        if(count < 20000000)begin
        oc_temp = 0;
        end
        
        else begin
        case(resetBTN)
       
            1'b0 : oc_temp = IA | IB;
        endcase
       end
    end 
    else if(oc_temp) begin
    
        case(resetBTN)
            //1'b0 : oc_temp = 1;
            1'b1 : oc_temp = 0;
        endcase
    end

    end
    
    assign oc = oc_temp;
    
endmodule



