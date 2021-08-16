`timescale 1ns / 1ps

module PIO(input clk,
           input rst,
			  input EN,
			  input [31:0] PData_in,
			  output reg[1:0] counter_set,
			  output [7:0] LED_out,
			  output reg[21:0] GPIOf0
          );
reg [7:0] LED;
assign LED_out = LED;
always @(negedge clk or posedge rst)
begin
	if (rst)
	begin
		LED <= 8'h2A; counter_set <= 2'b00;GPIOf0 <= 22'b0;
	end
	else begin
		if (EN) {GPIOf0,LED,counter_set} <= PData_in;
		else begin LED <= LED; counter_set<=counter_set;end
	end
end
endmodule
