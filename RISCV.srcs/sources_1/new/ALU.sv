`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2020 03:51:10 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] sreg2,
    input [31:0] sreg1,
    input sel, //invert/SRA signal
    input [2:0] funcSel, //this is the last 2 bits of func3
    output [31:0] result
    );
  wire [2:0] opState = {sel,funcSel};
  assign result       = (opState==4'b0000)?(sreg2+sreg1): //add
                        (opState==4'b1100)?(sreg1+1+~sreg2): //sub
                        (opState==4'b0001)?(sreg2&sreg1): //and
                        (opState==4'b0010)?(sreg2|sreg1): //or
                        (opState==4'b0011)?(sreg2^sreg1): //xor
                        (opState==4'b0100)?(($signed(sreg1)<$signed(sreg2)? 32'b1 : 31'b0)): //slt
                        (opState==4'b0001)?((sreg1<sreg2? 32'b1 :31'b0)): //sltu
                        (opState==4'b0010)?(sreg1<<sreg2[4:0]): //sll
                        (opState==4'b0011)?(sreg1>>sreg2[4:0]): //srl    
                        (opState==4'b1011)?(sreg1>>>sreg2[4:0]): //sra                    
                         31'bx; //default case
endmodule
