`timescale 1ns / 1ps

module REG32(
input wire clk,
input wire rst,
input wire CE,
input wire [31:0] D,
output reg [31:0] Q = 32'b0
    );
	 
	 always@(posedge clk or posedge rst)
	 begin
		if(rst)	Q <= 32'b0;
		else if(clk & CE) Q <= D;
	 end


endmodule

module REG5(
input wire clk,
input wire rst,
input wire CE,
input wire [4:0] D,
output reg [4:0] Q
    );
	 
	 always@(posedge clk or posedge rst)
	 begin
		if(rst)	Q <= 5'b0;
		else if(clk && CE) Q <= D;
	 end


endmodule
