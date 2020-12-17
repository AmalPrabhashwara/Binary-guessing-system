`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2020 11:44:58 AM
// Design Name: 
// Module Name: ShowRepeatingSystemVal
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

//BLINKING 16 LEDS TO SHOW THE SYSTEM VAL
module ShowRepeatingSystemVal(
input clk,
input [3:0]SystemVal,
output reg [15:0]led
    );
    
always @(posedge clk)begin
case(SystemVal)
    4'b0000:led<=16'h0001;
    4'b0001:led<=16'h0002;
    4'b0010:led<=16'h0004;
    4'b0011:led<=16'h0008;
    4'b0100:led<=16'h0010; 
    4'b0101:led<=16'h0020;
    4'b0110:led<=16'h0040; 
    4'b0111:led<=16'h0080;
    4'b1000:led<=16'h0100;
    4'b1001:led<=16'h0200;
    4'b1010:led<=16'h0400; 
    4'b1011:led<=16'h0800; 
    4'b1100:led<=16'h1000;
    4'b1101:led<=16'h2000; 
    4'b1110:led<=16'h4000; 
    4'b1111:led<=16'h8000;    
endcase
end

endmodule
