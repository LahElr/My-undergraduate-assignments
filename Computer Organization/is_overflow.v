`timescale 1ns / 1ps

module is_overflow(
	input wire [3:0] ALUsel,
	input wire signOp1,
	input wire signOp2,
	input wire signRes,
	output wire overflow
    );
	/*pos+pos=neg;neg+neg=pos;pos-neg=neg;neg-pos=pos*/ 
	wire isAdd,isSub;
	assign isAdd = (ALUsel === 4'h2);
	assign isSub = (ALUsel === 4'h6 || ALUsel === 4'h7);
	
	wire pre_overflow;
	wire [2:0] signs;
	assign signs = {signOp1,signOp2,signRes};
	
	assign pre_overflow = ( (isAdd & ((signs === 3'b001)|(signs === 3'b110)) ) | (isSub & ((signs === 3'b011)|(signs === 3'b100)) ) );
	
	assign overflow = (isAdd | isSub) ? pre_overflow:1'b0;


endmodule
