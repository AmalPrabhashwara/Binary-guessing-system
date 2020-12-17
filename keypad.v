`timescale 1ns / 1ps


//OUTPUT THE CORRECT KEY PRESSED
module keypad(
input clk,
input [3:0]out,
input [3:0]in,
output reg [4:0]y
    );

always @(posedge clk)begin
case(out)
   4'b0001:begin
       if(in==4'b0001)begin y<=0;end
       else if(in==4'b0010)begin y<=1;end
       else if(in==4'b0100)begin y<=2;end
       else if(in==4'b1000)begin y<=3;end
       else begin y<=16;end
   end
   
   4'b0010:begin
       if(in==4'b0001)begin y<=4;end
       else if(in==4'b0010)begin y<=5;end
       else if(in==4'b0100)begin y<=6;end
       else if(in==4'b1000)begin y<=7;end
       else begin y<=16;end
   end
   
   4'b0100:begin
       if(in==4'b0001)begin y<=8;end
       else if(in==4'b0010)begin y<=9;end
       else if(in==4'b0100)begin y<=10;end
       else if(in==4'b1000)begin y<=11;end
       else begin y<=16;end
   end
   
   4'b1000:begin
       if(in==4'b0001)begin y<=12;end
       else if(in==4'b0010)begin y<=13;end
       else if(in==4'b0100)begin y<=14;end
       else if(in==4'b1000)begin y<=15;end
       else begin y<=16;end
   end   
 endcase
end
endmodule
