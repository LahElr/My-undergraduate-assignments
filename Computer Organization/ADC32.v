`timescale 1ns / 1ps

module ADC32(
input wire C0,
input wire [31:0] A,
input wire [31:0] B,
output wire [31:0] C,
output wire Co
    );
	 
	 wire [32:0] D;
	 assign D=A+B+C0;
	 assign Co=D[32];
	 assign C=D[31:0];


endmodule
