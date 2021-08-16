`timescale 1ns / 1ps

module GPIO(input clk,
            input rst,
				input Start,
				input EN,
				input [31:0] P_Data,
				output reg[1:0] counter_set,
				output [15:0] LED_out,
				output led_clk,
				output led_sout,
				output led_clrn,
				output LED_PEN,
				output reg[13:0] GPIOf0
            );
reg [15:0] LED;
	assign LED_out = LED;
	always @(negedge clk or posedge rst) begin
		if (rst) begin LED <= 16'h2A2A; counter_set <= 2'b00; end
		else if (EN) {GPIOf0[13:0],LED,counter_set} <= P_Data;
			  else begin LED <= LED; counter_set <= counter_set; end
	end
	
	P2S #(.DATA_BITS(16),.DATA_COUNT_BITS(4),.DIR(0))
		P2LED(.clk(clk),
				.rst(rst),
				.Start(Start),
				.PData(~LED),
				.sclk(led_clk),
				.sclrn(led_clrn),
				.sout(led_sout),
				.EN(LED_PEN)
				);
endmodule
