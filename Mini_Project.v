`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2021 03:09:33 PM
// Design Name: 
// Module Name: Mini_Project
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


module Mini_Project(
input [1:0] SW,
input clock,
input [2:0] SWposA,
input [2:0] SWposB,
output reg MotorA,
output reg MotorB,
output IN1,
output IN2,
output IN3,
output IN4,
input  IA,
input IB,
input reset, 
output a, b, c, d, e, f, g, dp,
output [3:0] an

   );
   
   PWM u1(.clock(clock), .SWposA(SWposA), .SWposB(SWposB), .PWMA(MotorA), .PWMB(MotorB), .IA(IA), .IB(IB), .oc(oc));
   Seven_seg u2(.clock(clock), .Dir(SW), .an(an), .IA(IA), .IB(IB), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .dp(dp));
   Comparator u3(.IA(IA), .IB(IB), .resetBTN(reset), .oc(oc), .clock(clock));
   
   assign IN1 = SW[0];
   
   assign IN2 = !SW[0];
   
   assign IN3 = SW[1];
   
   assign IN4 = !SW[1];
 
endmodule

module PWM(
input clock,

input [2:0] SWposA,
input [2:0] SWposB,
output reg PWMA,
output reg PWMB,
input IA,
input IB,
output oc
);

reg [20:0] counter;
reg [20:0] widthA;
reg PWM_tempA;
reg [20:0] widthB;
reg PWM_tempB;

initial begin
    counter = 0;
    widthA = 0;
    widthB = 0;
    PWM_tempA = 0;
    PWM_tempB = 0;
    
end

always@(posedge clock) begin
    if (counter == 1666666)
        counter = 0;
    else
        counter <= counter + 1;
    
    if (counter < widthA) begin 
        PWM_tempA <=1;
        end
        
    else begin 
      PWM_tempA <=0;
    end
end

always@(posedge clock) begin
    case(SWposA)
    3'b000 : widthA = 21'd0; //0%
    
    3'b001 : widthA = 21'd416666;
    3'b100 : widthA = 21'd416666;
    3'b010 : widthA = 21'd416666;
    
    3'b011 : widthA = 21'd833333;//50%
    3'b110 : widthA = 21'd833333;
    3'b101 : widthA = 21'd833333;
    
    3'b111 : widthA = 21'd1250000;//75%
    
    default : widthA = 20'd0;
    
    endcase
    
    case(oc)
        1 : widthA = 21'd0;
    endcase
    
end

assign PWMA = PWM_tempA;
//always@(*) begin

//if(IA == 1) begin
//assign PWMA = PWM_tempA/2; // will assign half the PWM to make the current back under the 1A threshold
//    end
//else begin
//assign PWMA = PWM_tempA; 
//    end
//end

    always@(posedge clock) begin
    if (counter == 1666666)
        counter = 0;
    else
        counter <= counter + 1;
    
    if (counter < widthB) begin 
        PWM_tempB <=1;
        end
        
       // else if(IB == 1) begin
       // PWM_tempB = 0;
       // end
        
    else begin 
      PWM_tempB <=0;
    end
end


always@(posedge clock) begin
    case(SWposB)
    3'b000 : widthB = 21'd0; //0%
    
    3'b001 : widthB = 21'd416666;//25%
    3'b010 : widthB = 21'd416666;
    3'b100 : widthB = 21'd416666;
    
    3'b011 : widthB = 21'd833333;//50%
    3'b110 : widthB = 21'd833333;
    3'b101 : widthB = 21'd833333;
    
    3'b111 : widthB = 21'd1250000;//75%
    
    default : widthB = 20'd0;
    
    endcase
    
    case(oc)
        1 : widthB = 21'd0;
    endcase
    
end 

assign PWMB = PWM_tempB;


endmodule 
    module Seven_seg(
    input clock,
    input reset,
    input IA,
    input IB,
    input [1:0] Dir, 
    output [3:0] an,
    output a, b, c, d, e, f, g, dp
    );
       
       
       
       
    localparam N = 18;

reg [N-1:0]count; //the 18 bit counter which allows us to multiplex at 1000Hz

always @ (posedge clock or posedge reset)
 begin
  if (reset)
   count <= 0;
  else
   count <= count + 1;
 end
reg [6:0] sseg;
reg [3:0] an_temp; //register for the 4 bit enable

always @ (*)
 begin
  case(count[N-1:N-2]) //using only the 2 MSB's of the counter 
   
   2'b00 :  //When the 2 MSB's are 00 enable the fourth display
    begin
     sseg = IA;
     an_temp = 4'b1110;
    end
   
   2'b01:  //When the 2 MSB's are 01 enable the third display
    begin
     sseg = IB;
     an_temp = 4'b1101;
    end
   
   2'b10:  //When the 2 MSB's are 10 enable the second display
    begin
     sseg = Dir[0];
     an_temp = 4'b1011;
    end
    
   2'b11:  //When the 2 MSB's are 11 enable the first display
    begin
     sseg = Dir[1];
     an_temp = 4'b0111;
    end
  endcase
 end
assign an = an_temp;

reg [6:0] sseg_temp;


always @ (*)
 begin
  case(sseg)
  0 :  sseg_temp = 7'b1000000; // display a 0 for current under 1 A and forward direction
  1 :  sseg_temp = 7'b1001111; // display a 1 for current over 1 A and backward direction
  
    

  
   default : sseg_temp = 7'b0111111; //dash
  endcase
 end
assign {g, f, e, d, c, b, a} = sseg_temp; 


assign dp = 1'b1; //since the decimal point is not needed, all 4 of them are turned off


endmodule

module Comparator(
    input IA, IB,   // input signals from motor A and motor B
    input resetBTN,  // reset button
    input clock,
    output oc      // overcurrent

    );
    
    reg oc_temp;
    reg [26:0] count;
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
    if(IA | IB) begin
       
     if(~oc_temp) begin
        if(count < 50000000)begin
        oc_temp = 0;
        end
        
        else begin
        case(resetBTN)
       
            1'b0 : oc_temp = IA | IB;
        endcase
       end
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




//module Comparator(
// input IA, IB,   // input signals from motor A and motor B
//    input resetBTN,  // reset button
//    input clock,
//    output oc       // overcurrent

//    );
    
//    reg oc_temp;
//    reg count;

//    initial begin
//        oc_temp = 0;
//        count = 0;
//    end
//    always@(posedge clock) begin
//        if(IA | IB) begin 
//        count <= count + 1;
        
//        end
//        else begin
//            count = 0;
//        end
//    end

//    always@(*) begin
  
//    if(IA | IB) begin
//        oc_temp = 1;
        
//    end 
//    if (resetBTN) begin
//        oc_temp = 0;
//    end
//    if(count < 50000000) begin
//        oc_temp = 0;
//    end

//    end

//    assign oc = oc_temp;
    
//endmodule




