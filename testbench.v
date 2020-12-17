`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2020 10:50:05 PM
// Design Name: 
// Module Name: testbench
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


module testbench;

    reg clock_100Mhz; // 100 Mhz clock source on Basys 3 FPGA
    reg start;//Start the system
    reg reset; // Try for new guess
    reg [3:0]in;//Receive column number of the pessed key
    wire [3:0] Anode_Activate; // anode signals of the 7-segment LED display
    wire [6:0] SevenSegDisplay;// cathode patterns of the 7-segment LED display
    wire [15:0] led; //Shows true or false condition of the guess
    wire [3:0]out;  // Give high pulses for the Rows of the keypad
    wire [2:0]ShowTrueFalse;
    
 initial 
 begin
 clock_100Mhz =1'b0;
 reset=1'b0;
 start=1'b1;
 in=0;
 forever #5 clock_100Mhz =~clock_100Mhz;
 end
 
top f5(
    clock_100Mhz,start,reset,in,Anode_Activate,SevenSegDisplay,led,out,ShowTrueFalse
    );
 
 initial begin
  #80000
  in=4'b0010;
  #80000
  reset=1;
  #10
  reset=0;
  #80000
  in=4'b0100;
  #80000
  reset=1;
  #10
  reset=0;
  #80000
  in=4'b1000;
  #80000
  reset=1;
  #10
  reset=0;
  #80000
  in=4'b0001;
  #80000
  reset=1;
  #10
  reset=0;
  end

    
    
    
endmodule
