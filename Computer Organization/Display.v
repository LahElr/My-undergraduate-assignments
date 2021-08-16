`timescale 1ns / 1ps

module Display(input clk,
               input rst,
					input Start,
					input Text,
					input flash,
					input mapup,
					input [31:0] Hexs,
					input [7:0] point,
					input [7:0] LES,
					output seg_clk,
					output seg_sout,
					output SEG_PEN,
					output seg_clrn
				   );
wire [7:0] Segment;
wire [63:0] Seg_map, o;
reg [31:0] Seg_mapup, Seg_maplow;
reg [63:0] SEG_TXT;

assign Seg_map = {Seg_mapup, Seg_maplow};
assign o = Text ? SEG_TXT : Seg_map;

always @* begin
	Hex2Seg(Hexs[31:28],LES[7],point[7],flash,SEG_TXT[63:56]);
	Hex2Seg(Hexs[27:24],LES[6],point[6],flash,SEG_TXT[55:48]);
	Hex2Seg(Hexs[23:20],LES[5],point[5],flash,SEG_TXT[47:40]);
	Hex2Seg(Hexs[19:16],LES[4],point[4],flash,SEG_TXT[39:32]);
	
	Hex2Seg(Hexs[15:12],LES[3],point[3],flash,SEG_TXT[31:24]);
	Hex2Seg(Hexs[11:8],LES[2],point[2],flash,SEG_TXT[23:16]);
	Hex2Seg(Hexs[7:4],LES[1],point[1],flash,SEG_TXT[15:8]);
	Hex2Seg(Hexs[3:0],LES[0],point[0],flash,SEG_TXT[7:0]);
end

always @* begin
	case(mapup)
		1'b0: begin Seg_maplow = 
		{Hexs[30], Hexs[15], Hexs[11], Hexs[23], Hexs[31], Hexs[22], Hexs[10], Hexs[3],
		 Hexs[28], Hexs[14], Hexs[9], Hexs[21], Hexs[29], Hexs[20], Hexs[8], Hexs[2],
		 Hexs[26], Hexs[13], Hexs[7], Hexs[19], Hexs[27], Hexs[18], Hexs[6], Hexs[1],
		 Hexs[24], Hexs[12], Hexs[5], Hexs[17], Hexs[25], Hexs[16], Hexs[4], Hexs[0]};
		 Seg_mapup = Seg_mapup;end
		1'b1: begin Seg_mapup = 
		{Hexs[30], Hexs[15], Hexs[11], Hexs[23], Hexs[31], Hexs[22], Hexs[10], Hexs[3],
		 Hexs[28], Hexs[14], Hexs[9], Hexs[21], Hexs[29], Hexs[20], Hexs[8], Hexs[2],
		 Hexs[26], Hexs[13], Hexs[7], Hexs[19], Hexs[27], Hexs[18], Hexs[6], Hexs[1],
		 Hexs[24], Hexs[12], Hexs[5], Hexs[17], Hexs[25], Hexs[16], Hexs[4], Hexs[0]};
		 Seg_maplow = Seg_maplow;end
	endcase
end
P2S      #(.DATA_BITS(64),.DATA_COUNT_BITS(6),.DIR(0))
         PT7SEG(.clk(clk),.rst(rst),.Start(Start),.PData(o),
                .sclk(seg_clk),.sclrn(seg_clrn),.sout(seg_sout),.EN(SEG_PEN));

task Hex2Seg;
	input [3:0] Hex;
	input LE, point, flash;
	output [7:0] Segment;
	
	reg en;
	reg [7:0] Segcode;
	begin
		en = LE & flash;
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
		Segment = Segcode;
	end
endtask		 
endmodule
