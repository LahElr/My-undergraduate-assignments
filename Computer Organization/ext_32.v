`timescale 1ns / 1ps

module Ext_32(
input wire [15:0] imm_16,
output wire [31:0] imm_32
    );
assign imm_32[15:0] = imm_16[15:0];

assign imm_32[16]=imm_32[15];
assign imm_32[17]=imm_32[15];
assign imm_32[18]=imm_32[15];
assign imm_32[19]=imm_32[15];
assign imm_32[20]=imm_32[15];
assign imm_32[21]=imm_32[15];
assign imm_32[22]=imm_32[15];
assign imm_32[23]=imm_32[15];
assign imm_32[24]=imm_32[15];
assign imm_32[25]=imm_32[15];
assign imm_32[26]=imm_32[15];
assign imm_32[27]=imm_32[15];
assign imm_32[28]=imm_32[15];
assign imm_32[29]=imm_32[15];
assign imm_32[30]=imm_32[15];
assign imm_32[31]=imm_32[15];

endmodule

module Extend(
input wire [15:0] imm_16,
input wire Sign,
output wire [31:0] imm_32
    );
assign imm_32[15:0] = imm_16[15:0];

wire extendor;
assign extendor = Sign ? imm_16[15] : 1'b0;

assign imm_32[16]=extendor;
assign imm_32[17]=extendor;
assign imm_32[18]=extendor;
assign imm_32[19]=extendor;
assign imm_32[20]=extendor;
assign imm_32[21]=extendor;
assign imm_32[22]=extendor;
assign imm_32[23]=extendor;
assign imm_32[24]=extendor;
assign imm_32[25]=extendor;
assign imm_32[26]=extendor;
assign imm_32[27]=extendor;
assign imm_32[28]=extendor;
assign imm_32[29]=extendor;
assign imm_32[30]=extendor;
assign imm_32[31]=extendor;

endmodule

