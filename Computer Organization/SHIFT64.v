`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:08:20 03/08/2020 
// Design Name: 
// Module Name:    SHIFT64 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SHIFT64(input clk,
					input SR,
					input SL,
					input S1,
					input S0,
					input [64:0] D,
					output [64:0] Q 
    );
parameter
	DATA_BITS = 64;
reg [DATA_BITS:0] sreg = 0;
assign Q = sreg;
always @(posedge clk) begin
	if ({S1,S0}==2'b11)
		sreg <= D;
	else if ({S1,S0}==2'b00)
		sreg <= sreg;
	else if ({S1,S0}==2'b01)
		sreg <= {SR,sreg[DATA_BITS:1]};
	else if ({S1,S0}==2'b10)
		sreg <= {sreg[DATA_BITS-1:0],SL};
end
endmodule
