`timescale 1ns / 1ps

module sll32(
input wire [31:0] A,
input wire [31:0] B,
output wire [31:0] res
    );
	 
	 wire [31:0] tres;
	 MUX32_32 MT32T32(
	 .sel(A[4:0]),
	 .In0({B[31:0]}),
	 .In1({B[30:0],1'b0}),
	 .In2({B[29:0],2'b0}),
	 .In3({B[28:0],3'b0}),
	 .In4({B[27:0],4'b0}),
	 .In5({B[26:0],5'b0}),
	 .In6({B[25:0],6'b0}),
	 .In7({B[24:0],7'b0}),
	 .In8({B[23:0],8'b0}),
	 .In9({B[22:0],9'b0}),
	 .In10({B[21:0],10'b0}),
	 .In11({B[20:0],11'b0}),
	 .In12({B[19:0],12'b0}),
	 .In13({B[18:0],13'b0}),
	 .In14({B[17:0],14'b0}),
	 .In15({B[16:0],15'b0}),
	 .In16({B[15:0],16'b0}),
	 .In17({B[14:0],17'b0}),
	 .In18({B[13:0],18'b0}),
	 .In19({B[12:0],19'b0}),
	 .In20({B[11:0],20'b0}),
	 .In21({B[10:0],21'b0}),
	 .In22({B[9:0],22'b0}),
	 .In23({B[8:0],23'b0}),
	 .In24({B[7:0],24'b0}),
	 .In25({B[6:0],25'b0}),
	 .In26({B[5:0],26'b0}),
	 .In27({B[4:0],27'b0}),
	 .In28({B[3:0],28'b0}),
	 .In29({B[2:0],29'b0}),
	 .In30({B[1:0],30'b0}),
	 .In31({B[0],31'b0}),
	 .O(tres)
	 );
	 
	 assign res = tres & {32{~(|{A[31:5]})}};


endmodule

module srl32(
input wire [31:0] A,
input wire [31:0] B,
output wire [31:0] res
    );
	 
	 wire [31:0] tres;
	 MUX32_32 MT32T32(
	 .sel(A[4:0]),
	 .In0({B[31:0]}),
	 .In1({1'b0,B[31:1]}),
	 .In2({2'b0,B[31:2]}),
	 .In3({3'b0,B[31:3]}),
	 .In4({4'b0,B[31:4]}),
	 .In5({5'b0,B[31:5]}),
	 .In6({6'b0,B[31:6]}),
	 .In7({7'b0,B[31:7]}),
	 .In8({8'b0,B[31:8]}),
	 .In9({9'b0,B[31:9]}),
	 .In10({10'b0,B[31:10]}),
	 .In11({11'b0,B[31:11]}),
	 .In12({12'b0,B[31:12]}),
	 .In13({13'b0,B[31:13]}),
	 .In14({14'b0,B[31:14]}),
	 .In15({15'b0,B[31:15]}),
	 .In16({16'b0,B[31:16]}),
	 .In17({17'b0,B[31:17]}),
	 .In18({18'b0,B[31:18]}),
	 .In19({19'b0,B[31:19]}),
	 .In20({20'b0,B[31:20]}),
	 .In21({21'b0,B[31:21]}),
	 .In22({22'b0,B[31:22]}),
	 .In23({23'b0,B[31:23]}),
	 .In24({24'b0,B[31:24]}),
	 .In25({25'b0,B[31:25]}),
	 .In26({26'b0,B[31:26]}),
	 .In27({27'b0,B[31:27]}),
	 .In28({28'b0,B[31:28]}),
	 .In29({29'b0,B[31:29]}),
	 .In30({30'b0,B[31:30]}),
	 .In31({31'b0,B[31]}),
	 .O(tres)
	 );
	 
	 assign res = tres & {32{~(|{A[31:5]})}};

endmodule

module sra32(
input wire [31:0] A,
input wire [31:0] B,
output wire [31:0] res
    );
	 
	 wire [31:0] tres;
	 MUX32_32 MT32T32(
	 .sel(A[4:0]),
	 .In0({B[31:0]}),
	 .In1({ {1{B[31]}} ,B[31:1]}),
	 .In2({ {2{B[31]}} ,B[31:2]}),
	 .In3({ {3{B[31]}} ,B[31:3]}),
	 .In4({ {4{B[31]}} ,B[31:4]}),
	 .In5({ {5{B[31]}} ,B[31:5]}),
	 .In6({ {6{B[31]}} ,B[31:6]}),
	 .In7({ {7{B[31]}} ,B[31:7]}),
	 .In8({ {8{B[31]}} ,B[31:8]}),
	 .In9({ {9{B[31]}} ,B[31:9]}),
	 .In10({ {10{B[31]}} ,B[31:10]}),
	 .In11({ {11{B[31]}} ,B[31:11]}),
	 .In12({ {12{B[31]}} ,B[31:12]}),
	 .In13({ {13{B[31]}} ,B[31:13]}),
	 .In14({ {14{B[31]}} ,B[31:14]}),
	 .In15({ {15{B[31]}} ,B[31:15]}),
	 .In16({ {16{B[31]}} ,B[31:16]}),
	 .In17({ {17{B[31]}} ,B[31:17]}),
	 .In18({ {18{B[31]}} ,B[31:18]}),
	 .In19({ {19{B[31]}} ,B[31:19]}),
	 .In20({ {20{B[31]}} ,B[31:20]}),
	 .In21({ {21{B[31]}} ,B[31:21]}),
	 .In22({ {22{B[31]}} ,B[31:22]}),
	 .In23({ {23{B[31]}} ,B[31:23]}),
	 .In24({ {24{B[31]}} ,B[31:24]}),
	 .In25({ {25{B[31]}} ,B[31:25]}),
	 .In26({ {26{B[31]}} ,B[31:26]}),
	 .In27({ {27{B[31]}} ,B[31:27]}),
	 .In28({ {28{B[31]}} ,B[31:28]}),
	 .In29({ {29{B[31]}} ,B[31:29]}),
	 .In30({ {30{B[31]}} ,B[31:30]}),
	 .In31({ {31{B[31]}} ,B[31]}),
	 .O(tres)
	 );
	 
	 assign res = (|{A[31:5]}) ? {32{B[31]}} : tres;

endmodule

module MUX32_32(
input wire [31:0] In0,
input wire [31:0] In1,
input wire [31:0] In2,
input wire [31:0] In3,
input wire [31:0] In4,
input wire [31:0] In5,
input wire [31:0] In6,
input wire [31:0] In7,
input wire [31:0] In8,
input wire [31:0] In9,
input wire [31:0] In10,
input wire [31:0] In11,
input wire [31:0] In12,
input wire [31:0] In13,
input wire [31:0] In14,
input wire [31:0] In15,
input wire [31:0] In16,
input wire [31:0] In17,
input wire [31:0] In18,
input wire [31:0] In19,
input wire [31:0] In20,
input wire [31:0] In21,
input wire [31:0] In22,
input wire [31:0] In23,
input wire [31:0] In24,
input wire [31:0] In25,
input wire [31:0] In26,
input wire [31:0] In27,
input wire [31:0] In28,
input wire [31:0] In29,
input wire [31:0] In30,
input wire [31:0] In31,
input wire [4:0] sel,
output reg [31:0] O
);

always@(*)
	case(sel)
		5'd0:O=In0;
		5'd1:O=In1;
		5'd2:O=In2;
		5'd3:O=In3;
		5'd4:O=In4;
		5'd5:O=In5;
		5'd6:O=In6;
		5'd7:O=In7;
		5'd8:O=In8;
		5'd9:O=In9;
		5'd10:O=In10;
		5'd11:O=In11;
		5'd12:O=In12;
		5'd13:O=In13;
		5'd14:O=In14;
		5'd15:O=In15;
		5'd16:O=In16;
		5'd17:O=In17;
		5'd18:O=In18;
		5'd19:O=In19;
		5'd20:O=In20;
		5'd21:O=In21;
		5'd22:O=In22;
		5'd23:O=In23;
		5'd24:O=In24;
		5'd25:O=In25;
		5'd26:O=In26;
		5'd27:O=In27;
		5'd28:O=In28;
		5'd29:O=In29;
		5'd30:O=In30;
		5'd31:O=In31;
		default:O=32'b0;
	endcase

endmodule






