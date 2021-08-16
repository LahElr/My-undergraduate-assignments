`timescale 1ns / 1ps
module MUX16T1_32(input wire [31:0] I0,
				input wire [31:0] I1,
				input wire [31:0] I2,
				input wire [31:0] I3,
				input wire [31:0] I4,
				input wire [31:0] I5,
				input wire [31:0] I6,
				input wire [31:0] I7,
				input wire [31:0] I8,
				input wire [31:0] I9,
				input wire [31:0] I10,
				input wire [31:0] I11,
				input wire [31:0] I12,
				input wire [31:0] I13,
				input wire [31:0] I14,
				input wire [31:0] I15,
				input wire [3:0] s,
				output reg [31:0] o
                );
always @*
	case (s)
		4'b0000: o <= I0;
		4'b0001: o <= I1;
		4'b0010: o <= I2;
		4'b0011: o <= I3;
		4'b0100: o <= I4;
		4'b0101: o <= I5;
		4'b0110: o <= I6;
		4'b0111: o <= I7;
		4'b1000: o <= I8;
		4'b1001: o <= I9;
		4'b1010: o <= I10;
		4'b1011: o <= I11;
		4'b1100: o <= I12;
		4'b1101: o <= I13;
		4'b1110: o <= I14;
		4'b1111: o <= I15;
		default:;
	endcase
endmodule

module MUX8T1_32(input wire [31:0] I0,
				input wire [31:0] I1,
				input wire [31:0] I2,
				input wire [31:0] I3,
				input wire [31:0] I4,
				input wire [31:0] I5,
				input wire [31:0] I6,
				input wire [31:0] I7,
				input wire [2:0] s,
				output reg [31:0] o
                );
always @*
	case (s)
		3'b000: o <= I0;
		3'b001: o <= I1;
		3'b010: o <= I2;
		3'b011: o <= I3;
		3'b100: o <= I4;
		3'b101: o <= I5;
		3'b110: o <= I6;
		3'b111: o <= I7;
		default:;
	endcase
endmodule

module MUX8T1_8(input wire [7:0] I0,
				input wire [7:0] I1,
				input wire [7:0] I2,
				input wire [7:0] I3,
				input wire [7:0] I4,
				input wire [7:0] I5,
				input wire [7:0] I6,
				input wire [7:0] I7,
			    input wire [2:0] s,
				output reg [7:0] o
                );
always @*
	case (s)
		3'b000: o <= I0;
		3'b001: o <= I1;
		3'b010: o <= I2;
		3'b011: o <= I3;
		3'b100: o <= I4;
		3'b101: o <= I5;
		3'b110: o <= I6;
		3'b111: o <= I7;
		default:;
	endcase
endmodule

module MUX8T1_4(input wire [3:0] I0,
				input wire [3:0] I1,
				input wire [3:0] I2,
				input wire [3:0] I3,
				input wire [3:0] I4,
				input wire [3:0] I5,
				input wire [3:0] I6,
				input wire [3:0] I7,
				input wire [2:0] s,
				output reg [3:0] o
                );
always @*
	case (s)
		3'b000: o <= I0;
		3'b001: o <= I1;
		3'b010: o <= I2;
		3'b011: o <= I3;
		3'b100: o <= I4;
		3'b101: o <= I5;
		3'b110: o <= I6;
		3'b111: o <= I7;
		default:;
	endcase
endmodule

module MUX4T1_32(input wire [31:0] I0,
				input wire [31:0] I1,
				input wire [31:0] I2,
				input wire [31:0] I3,
				input wire [1:0] s,
				output reg [31:0] o
                );
always @*
	case (s)
		2'b00: o <= I0;
		2'b01: o <= I1;
		2'b10: o <= I2;
		2'b11: o <= I3;
		default:;
	endcase
endmodule

module MUX4T1_5(input wire [4:0] I0,
				input wire [4:0] I1,
				input wire [4:0] I2,
				input wire [4:0] I3,
				input wire [1:0] s,
				output reg [4:0] o
                );
always @*
	case (s)
		2'b00: o <= I0;
		2'b01: o <= I1;
		2'b10: o <= I2;
		2'b11: o <= I3;
		default:;
	endcase
endmodule

module MUX2T1_64(input wire [63:0] I0,
				input wire [63:0] I1,
				input wire s,
				output wire [63:0] o
                );
    assign o = (s?I1:I0);
endmodule

module MUX2T1_32(input wire [31:0] I0,
				input wire [31:0] I1,
				input wire s,
				output wire [31:0] o
                );
    assign o = (s?I1:I0);
endmodule

module MUX2T1_8(input wire [7:0] I0,
				input wire [7:0] I1,
				input wire s,
				output wire [7:0] o
                );
    assign o = (s?I1:I0);
endmodule

module MUX2T1_5(input wire [4:0] I0,
				input wire [4:0] I1,
				input wire s,
				output wire [4:0] o
                );
    assign o = (s?I1:I0);
endmodule