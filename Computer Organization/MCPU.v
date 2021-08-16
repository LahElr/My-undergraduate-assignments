`timescale 1ns / 1ps

module MCPU
(
	input wire INT,
	input wire clk,
	input wire MIO_ready,
	input wire reset,
	input wire [31:0] Data_in,
	
	output wire mem_w,
	output wire [31:0] PC_out,
	output wire [31:0] inst_out,
	output wire [31:0] Data_out,
	output wire [31:0] Addr_out,
	output wire CPU_MIO,
	output wire [4:0] state
);

wire zero;
wire overflow;
wire MemRead;
wire MemWrite;
//wire invMemRead;
wire IorD;
wire IRWrite;
wire RegWrite;
wire PCWrite;
wire PCWriteCond;
wire Branch;
wire sign;
wire [1:0] RegDst;
wire [1:0] DatatoReg;
wire [1:0] ALUSrcB;
wire [1:0] ALUSrcA;
wire [1:0] PCSource;
wire [3:0] ALU_operation;

MCtrl Controller(.clk(clk),
					  .reset(reset),
					  .zero(zero),
					  .overflow(overflow),
					  .MIO_ready(MIO_ready),
					  .Inst_in(inst_out[31:0]),
					  .MemRead(MemRead),
					  .MemWrite(MemWrite),
					  .CPU_MIO(CPU_MIO),
					  .IorD(IorD),
					  .IRWrite(IRWrite),
					  .RegWrite(RegWrite),
					  .ALUSrcA(ALUSrcA[1:0]),
					  .PCWrite(PCWrite),
					  .PCWriteCond(PCWriteCond),
					  .Branch(Branch),
					  .RegDst(RegDst[1:0]),
					  .MemtoReg(DatatoReg[1:0]),
					  .ALUSrcB(ALUSrcB[1:0]),
					  .PCSource(PCSource[1:0]),
					  .ALU_operation(ALU_operation[3:0]),
					  .state_out(state[4:0]),
					  .sign(sign));

MDPath DataPath(.clk(clk),
					 .reset(reset),
					 .MIO_ready(MIO_ready),
					 .IorD(IorD),
					 .IRWrite(IRWrite),
					 .RegWrite(RegWrite),
					 .ALUSrcA(ALUSrcA[1:0]),
					 .PCWrite(PCWrite),
					 .PCWriteCond(PCWriteCond),
					 .Branch(Branch),
					 .RegDst(RegDst[1:0]),
					 .MemtoReg(DatatoReg[1:0]),
					 .ALUSrcB(ALUSrcB[1:0]),
					 .PCSource(PCSource[1:0]),
					 .ALU_operation(ALU_operation[3:0]),
					 .data2CPU(Data_in[31:0]),
					 .zero(zero),
					 .overflow(overflow),
					 .PC_Current(PC_out[31:0]),
					 .Inst(inst_out[31:0]),
					 .data_out(Data_out[31:0]),
					 .M_addr(Addr_out[31:0]),
					 .sign(sign));

assign mem_w = (~MemRead)&(MemWrite);
/*
INV inv1(.I(MemRead),
			.O(invMemRead));
AND2 and1(.I0(invMemRead),
		    .I1(MemWrite),
			 .O(mem_w));
*/
endmodule
