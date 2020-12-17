# Binary-guessing-system

## Introduction
The Binary Guessing System is capable of guessing the present value of the system which is
developed using HDL language and demonstrated using FPGA board with a 4x4 keypad. The
present value is given as a four-bit binary number which increases its value by one each an every
0.25ms, and repeats. The guessing input of the user can be given by an external 4x4 keypad. At
the instant that the user has given an input to the system both guess value and system present values shown in the 4 seven segment display 
units and as the user input matches the present
value, the system indicates the guess is TRUE, and if the user input does not match with the present
value, the system the guess is FALSE.

## Interfacing keypad
Here 4 by 4 matrix keypad has been used. There are 8 wires coming out from the keypad 4 representing raws and 4 representing columns.
They have been connected to the pmod pins of FPGA. Inorder to identify the pressed key it sends high pulses in such a way only one raw 
sense voltage high for perticular 4 clocks(40 ns). And it is repeated over 4 wires connected to raws of the keypad. The 4 wires connected to the columns are input to the FPGA and it is sensed in slow clock in oder to reduce noise effect because of bouncing of the buttons.



