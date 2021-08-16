`timescale 1ns / 1ps

module clk_div(
	input wire rst,
	input wire clk,
	input wire STEP,
	output reg [31:0] clkdiv,
	output wire Clk_CPU
    );
	
	always@(posedge clk or posedge rst)
	begin
		clkdiv <= (rst)? 32'b0 : clkdiv+1;
	end
	
	assign Clk_CPU = (STEP) ? clkdiv[27] : clkdiv[1];
	
endmodule
