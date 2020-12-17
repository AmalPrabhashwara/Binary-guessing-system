`timescale 1ns / 1ps

module top(
    input clock_100Mhz, // 100 Mhz clock source on Basys 3 FPGA
    input start,//Start the system
    input reset, // Try for new guess
    input [3:0]in,//Receive column number of the pessed key
    output [3:0] Anode_Activate, // anode signals of the 7-segment LED display
    output [6:0] SevenSegDisplay,// cathode patterns of the 7-segment LED display
    output [15:0] led, //Shows true or false condition of the guess
    output reg [3:0]out,  // Give high pulses for the Rows of the keypad
    output reg[2:0]ShowTrueFalse
    );
   
    reg [26:0] count;//counting clocks for change system val
    reg [3:0] SystemVal; //Rotating 4 bit system generated value
   
    reg [3:0]GuessNum; //Store the key value pressed by the user
    reg [3:0] SystemValAtGuess; //The system generated value when the guess is done
    reg [1:0]state; //Three states of the comparator
    reg [3:0]count2; //Counting clocks for sending high pulses for each row of the keypad after every 4 clocks
    
    wire [4:0]KeyState; //state of the key pad. Receive the number of the key pressed by user which output by the keypad.v module
    
    localparam s1=0;  //three state of the state machine
    localparam s2=1;
    localparam s3=2;
    
    initial begin  //Define Initial state
     count=0;
     SystemVal=0;
     state=0;
     SystemValAtGuess=0;
     GuessNum=0;
     count2=0;
    end

    always @(posedge clock_100Mhz)begin  // changing SystemVal at each 0.25 ms 
    if(start==1)begin    //if and only start is on the system will generate values
    if(count==25000)begin    //25000000-250ms
      count<=0;
      SystemVal<=SystemVal+1;
    end
    else
     count<=count+1;
    end
    else
     SystemVal<=0;
    end
    
   
 //Compare the GuessNum and SystemVal
always @(posedge clock_100Mhz)begin
 case(state)
 
 s1:begin
   if(start==1)
     state<=s2;
 end

 s2:begin
  if(start==1)begin
  
  if(KeyState==5'b10000)begin //KeyState is 5'b10000 when any key is not pressed
   ShowTrueFalse<=3'b001; //Turn on first led and off others when any key is not pressed
   end
  else if(KeyState==SystemVal)begin
   ShowTrueFalse<=3'b010;   //Turn on seceond led when GuessNum and SystemVal are equal 
   GuessNum<=KeyState;   //Assign current keyState to GuessNum
   SystemValAtGuess<=SystemVal;//Assign current SystemVal to SystemValAtGuess
   state<=s3;  
   end
  else if(KeyState!=SystemVal) begin
   ShowTrueFalse<=3'b100;  //Turn on third led when GuessNum and SystemVal are not equal 
   GuessNum<=KeyState;
   SystemValAtGuess<=SystemVal;
   state<=s3;
   end
   
   end
   end
   
   s3:begin //Keep leds and displayed val in seven segment displays untill the reset is pressed 
   if(reset==1 | start==0)begin //Once reset is pressed or start is offed Seven Segment display set to show zero and send the state to S1 
     state<=s1;  
     SystemValAtGuess<=0;
     GuessNum<=0;
     end
   end
  endcase 
end

//Count2 stepping up at every posedge of clock
always @(posedge clock_100Mhz)begin
 count2<=count2+1;
end

//set keypad columns high at each 4 clcks.
always @(posedge clock_100Mhz)begin
 case(count2[3:2]) 
   2'b00:out<=4'b0001;
   2'b01:out<=4'b0010;
   2'b10:out<=4'b0100;
   2'b11:out<=4'b1000;
 endcase
end

keypad f1(clock_100Mhz,out,in,KeyState);//Output the keyState(Correct key) my matching rows and column which were actived when the key is pressed
display f2(clock_100Mhz,reset,SystemValAtGuess,GuessNum,Anode_Activate,SevenSegDisplay);//Functioning the seven segment displays 
ShowRepeatingSystemVal f3(clock_100Mhz,SystemVal,led);//Funtioning the 16 LEDs


endmodule