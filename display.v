module display(
input clock_100Mhz,
input reset,
input [3:0]SystemValAtGuess,
input [3:0]GuessNum,
output reg [3:0]Anode_Activate,
output reg [6:0]SevenSegDisplay
);
reg [19:0] Refresh_Anode; //  cperating 4 seven segment-activating signals with 2.6ms digit period
wire [1:0] SevenSegment_activating_counter;  //Activate 4 seven segment one by one
reg [3:0] Bin2Dec; //use for converting binary to decimal

initial begin
  Refresh_Anode=0;
end

 always @(posedge clock_100Mhz)
    begin 
        if(reset==1)
            Refresh_Anode <= 0;
        else
            Refresh_Anode <= Refresh_Anode + 1;
    end 
    
    assign SevenSegment_activating_counter = Refresh_Anode[19:18];
   
    always @(posedge clock_100Mhz)
    begin
        case(SevenSegment_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            // activate SevenSegment1 and Deactivate SevenSegment2, SevenSegment3, SevenSegment4
            Bin2Dec = SystemValAtGuess/10;
            // the first digit of the SystemValAtGuess
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
            // activate SevenSegment2 and Deactivate SevenSegment1, SevenSegment3, SevenSegment4
            Bin2Dec = SystemValAtGuess % 10;
            // the second digit of the SystemValAtGuess
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
            // activate SevenSegment3 and Deactivate SevenSegment2, SevenSegment1, SevenSegment4
            Bin2Dec = ((GuessNum % 1000)%100)/10;
            // the first digit of the GuessNum
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            // activate SevenSegment4 and Deactivate SevenSegment2, SevenSegment3, SevenSegment1
            Bin2Dec = ((GuessNum % 1000)%100)%10;              
            // the seceond digit of the GuessNum    
               end
        endcase
    end
    
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(Bin2Dec)
        4'b0000: SevenSegDisplay = 7'b0000001; // "0"     
        4'b0001: SevenSegDisplay = 7'b1001111; // "1" 
        4'b0010: SevenSegDisplay = 7'b0010010; // "2" 
        4'b0011: SevenSegDisplay = 7'b0000110; // "3" 
        4'b0100: SevenSegDisplay = 7'b1001100; // "4" 
        4'b0101: SevenSegDisplay = 7'b0100100; // "5" 
        4'b0110: SevenSegDisplay = 7'b0100000; // "6" 
        4'b0111: SevenSegDisplay = 7'b0001111; // "7" 
        4'b1000: SevenSegDisplay = 7'b0000000; // "8"     
        4'b1001: SevenSegDisplay = 7'b0000100; // "9" 
        default: SevenSegDisplay = 7'b0000001; // "0"
        endcase
    end
    



endmodule