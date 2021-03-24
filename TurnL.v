`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2021 12:10:28 AM
// Design Name: 
// Module Name: TurnL
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


module TurnL(

input clock,
input oc,
output IN1,
output IN2,
output IN3,
output IN4,
output PWMA,
output PWMB
);


// all assuming IN1 = right forward, IN2 = Right back, IN3 = Left forward, and IN4 = Left back
assign IN1 = 1; 
assign IN2 = 0;
assign IN3 = 0;
assign IN4 = 1;
    
reg [31:0] scount;
reg [20:0] counter;
reg [20:0] width;
reg PWM_tempA;
reg PWM_tempB;
reg done_temp;

initial begin
    counter = 0;
    scount = 0;
    done_temp = 0;
    width = 21'd416666; // 25%
    PWM_tempA = 0;
    PWM_tempB = 0;
    
end

always@(posedge clock) begin
    if (counter == 1666667)
        counter = 0;
    else
        counter <= counter + 1;
    if (oc) begin
        PWM_tempA = 0;
    end
    
    else if (counter < width) begin
        PWM_tempA <=1; 
    end
    
    else begin 
      PWM_tempA <=0;
    end
end


assign PWMA = PWM_tempA;


always@(posedge clock) begin
    if (counter == 1666667) begin
        counter = 0; end
        
    else begin
        counter <= counter + 1;
        end
        
    if (oc) begin
        PWM_tempB = 0;
    end
    
    else if (counter < width) begin
        PWM_tempB <=1; 
    end
    
    else begin 
      PWM_tempB <=0;
    end
end


assign PWMB = PWM_tempB;

always @ (posedge clock) begin

scount <= scount + 1;


if (scount == 50000000) begin  // .5 sec

done_temp = 1;
end 
else begin
done_temp = 0;
end
end
assign done = done_temp;



endmodule
