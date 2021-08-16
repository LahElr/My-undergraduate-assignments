`timescale 1ns / 1ps

module Disp2Hex(input [2:0] Scan,
                input Text,
					 input flash,
					 input [31:0] Hexs,
					 input [7:0] points,
					 input [7:0] LES,
					 output [7:0] SEGMENT,
					 output reg[3:0] AN
                );
wire [7:0] SEG_TXT;
reg p, LE;
reg [3:0] Hexo;
reg [7:0] Seg_map;
	assign SEGMENT = Text ? SEG_TXT : Seg_map;
	
	always @* begin
		case (Scan)
			3'b000: begin Hexo <= Hexs[3:0]; AN <= 4'b1110;
						     p <= points[0]; LE <= LES[0]; end
			3'b001: begin Hexo <= Hexs[7:4]; AN <= 4'b1101;
						     p <= points[1]; LE <= LES[1]; end
			3'b010: begin Hexo <= Hexs[11:8]; AN <= 4'b1011;
						     p <= points[2]; LE <= LES[2]; end
			3'b011: begin Hexo <= Hexs[15:12]; AN <= 4'b0111;
						     p <= points[3]; LE <= LES[3]; end
			3'b100: begin Hexo <= Hexs[19:16]; AN <= 4'b1110;
						     p <= points[4]; LE <= LES[4]; end
			3'b101: begin Hexo <= Hexs[23:20]; AN <= 4'b1101;
						     p <= points[5]; LE <= LES[5]; end
			3'b110: begin Hexo <= Hexs[27:24]; AN <= 4'b1011;
						     p <= points[6]; LE <= LES[6]; end
			3'b111: begin Hexo <= Hexs[31:28]; AN <= 4'b0111;
						     p <= points[7]; LE <= LES[7]; end
		endcase
	end
	always @* begin
		case (Scan)
			3'b000: begin Seg_map <= {Hexs[24], Hexs[12], Hexs[5], Hexs[17], Hexs[25], Hexs[16], Hexs[4], Hexs[0]};end
			3'b001: begin Seg_map <= {Hexs[26], Hexs[13], Hexs[7], Hexs[19], Hexs[27], Hexs[18], Hexs[6], Hexs[1]};end
			3'b010: begin Seg_map <= {Hexs[28], Hexs[14], Hexs[9], Hexs[21], Hexs[29], Hexs[20], Hexs[8], Hexs[2]};end
			3'b011: begin Seg_map <= {Hexs[30], Hexs[15], Hexs[11], Hexs[23], Hexs[31], Hexs[22], Hexs[10], Hexs[3]};end
			3'b100: begin Seg_map <= {Hexs[24], Hexs[12], Hexs[5], Hexs[17], Hexs[25], Hexs[16], Hexs[4], Hexs[0]};end
			3'b101: begin Seg_map <= {Hexs[26], Hexs[13], Hexs[7], Hexs[19], Hexs[27], Hexs[18], Hexs[6], Hexs[1]};end
			3'b110: begin Seg_map <= {Hexs[28], Hexs[14], Hexs[9], Hexs[21], Hexs[29], Hexs[20], Hexs[8], Hexs[2]};end
			3'b111: begin Seg_map <= {Hexs[30], Hexs[15], Hexs[11], Hexs[23], Hexs[31], Hexs[22], Hexs[10], Hexs[3]};end
		endcase
	end
	assign en = LE & flash;
	assign SEG_TXT = Hex2Seg(Hexo,p,en);
	
	function [7:0] Hex2Seg;
	input [3:0] Hex;
	input point, en;
	reg [7:0] Segcode;
	begin
		case (Hex)
			0:     Segcode = {~point,7'b1000000 | {7{en}}};
	      1:     Segcode = {~point,7'b1111001 | {7{en}}};
			2:     Segcode = {~point,7'b0100100 | {7{en}}};
			3:     Segcode = {~point,7'b0110000 | {7{en}}};
			4:     Segcode = {~point,7'b0011001 | {7{en}}};
	      5:     Segcode = {~point,7'b0010010 | {7{en}}};
			6:     Segcode = {~point,7'b0000010 | {7{en}}};
			7:     Segcode = {~point,7'b1111000 | {7{en}}};
			8:     Segcode = {~point,7'b0000000 | {7{en}}};
	      9:     Segcode = {~point,7'b0010000 | {7{en}}};
			'hA:     Segcode = {~point,7'b0001000 | {7{en}}};
			'hB:     Segcode = {~point,7'b0000011 | {7{en}}};
			'hC:     Segcode = {~point,7'b1000110 | {7{en}}};
	      'hD:     Segcode = {~point,7'b0100001 | {7{en}}};
			'hE:     Segcode = {~point,7'b0000110 | {7{en}}};
			'hF:     Segcode = {~point,7'b0001110 | {7{en}}};
		endcase
		Hex2Seg = Segcode;
	end
	endfunction
	
endmodule
