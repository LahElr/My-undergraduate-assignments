`timescale 1ns / 1ps

module P2S(input clk,
           input rst,
			  input Start,
			  input [63:0] PData,
			  output sclk,
			  output sclrn,
			  output sout,
			  output reg EN
    );
parameter
	DATA_BITS = 64,
	DATA_COUNT_BITS = 6,
	DIR = 1;
wire S1, S0, SL, SR, shift;
wire [DATA_BITS:0] D, Q;
reg [1:0] Go = 2'b00, S = 2'b00;

always @(posedge clk)
	Go <= {Go[0], Start};
	assign shift = (Go==2'b01)?1'b1:1'b0;
	
assign {SL, SR} = 2'b11;
assign D        = DIR ? {1'b0,PData}:{PData,1'b0};
assign {S1, S0} = DIR ? {S[0], S[1]} : S;

assign sout     = DIR ? Q[0] : Q[DATA_BITS];
wire finish     = DIR ? &Q[DATA_BITS:1] : &Q[DATA_BITS-1:0];

SHIFT64 #(.DATA_BITS(DATA_BITS))
			PTOS(.clk(clk),
				  .SR(SR),.SL(SL),
				  .S1(S1),.S0(S0),
				  .D(D),.Q(Q));

always @* begin
	if (shift & finish)
		begin EN <= 0; S <= 2'b11; end
	else if (!finish)
		begin EN <= 0; S <= 2'b10; end
		else begin EN <= 1; S <= 2'b00; end
end

assign sclk = finish | clk;
assign sclrn = 1;
endmodule
