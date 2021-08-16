`timescale 1ns / 1ps

module     MDPath(input clk,
					   input reset,
					  
					   input MIO_ready,
					   input IorD,
					   input IRWrite,
					   input [1:0] RegDst,
					   input RegWrite,
					   input [1:0]MemtoReg,
					   input [1:0]ALUSrcA,
					  
					   input[1:0]ALUSrcB,
					   input[1:0]PCSource,
					   input PCWrite,
					   input PCWriteCond,	
					   input Branch,
					   input[3:0]ALU_operation,
						input sign,
					  
					   output[31:0]PC_Current,
					   input[31:0]data2CPU,
					   output[31:0]Inst,
					   output[31:0]data_out,
					   output[31:0]M_addr,
					  
					   output zero,
					   output overflow
					  );	

	wire [31:0]MDR_out;
	wire [4:0]Write_Address;
	wire [31:0]Write_Data;
	wire [31:0]ALU_Out;
	wire [31:0]Imm_32;
	wire [31:0]rdata_A;
	wire [31:0]A;
	wire [31:0]B;
	wire [31:0]res;
	wire [31:0]PC_in_data;
	wire XOR_1_OUT;
	wire INV_OUT;
	wire AND_1_OUT;
	wire AND_2_OUT;
	wire OR_1_OUT;
	
	REG32 IR(.clk(clk),
				.rst(reset),
				.CE(IRWrite),
				.D(data2CPU[31:0]),
				.Q(Inst[31:0])
				);
				
	REG32 MDR(.clk(clk),
				 .rst(1'b0),
				 .CE(1'b1),
				 .D(data2CPU[31:0]),
				 .Q(MDR_out[31:0])
				 );
	
	
	MUX4T1_5 Regs_write_addr(.s(RegDst[1:0]),
									 .I0(Inst[20:16]),
									 .I1(Inst[15:11]),
									 .I2(5'b11111), // $ra
									 .I3(5'b00000), // unused
									 .o(Write_Address[4:0])
									 );
	
	
	MUX4T1_32 Regs_write_data(.s(MemtoReg[1:0]),
									 .I0(ALU_Out[31:0]),
									 .I1(MDR_out[31:0]),
									 .I2({Inst[15:0],16'b0}), // lui
									 .I3(PC_Current[31:0]), // $ra
									 .o(Write_Data[31:0])
									 );
						
	Extend  Ext_32(.imm_16(Inst[15:0]),
					   .imm_32(Imm_32[31:0]),
						.Sign(sign)
					   );
					
	Regs    U2(.clk(clk),
				  .rst(reset),
				  .R_addr_A(Inst[25:21]),
				  .R_addr_B(Inst[20:16]),
				  .Wt_addr(Write_Address[4:0]),
				  .Wt_data(Write_Data[31:0]),
				  .L_S(RegWrite),
				  .rdata_A(rdata_A[31:0]),
				  .rdata_B(data_out[31:0])
				  );
	
	MUX4T1_32  ALU_A(.s(ALUSrcA),
						  .I0(PC_Current[31:0]),
						  .I1(rdata_A[31:0]), //regs_a
						  .I2({27'b0, Inst[10:6]}), // shamt
						  .I3(32'b0), // unused
						  .o(A[31:0])
						  );
	
	MUX4T1_32 ALU_B(.s(ALUSrcB[1:0]),
						 .I0(data_out[31:0]), //regs_b
						 .I1(32'h0000_0004), //4
						 .I2(Imm_32[31:0]), //extended
						 .I3({Imm_32[29:0],2'b00}), //offset(extended*4)
						 .o(B[31:0])
						 );
						
	alu	U1(.A(A[31:0]),
				.B(B[31:0]),
				.ALU_Ctrl(ALU_operation[3:0]),
				.zero(zero),
				.res(res[31:0]),
				.overflow(overflow)
				//Co没有
				);
	
		
	REG32 ALUOut(.clk(clk),
				    .rst(1'b0),
				    .CE(1'b1),
				    .D(res[31:0]),
				    .Q(ALU_Out[31:0])
				    );
	
	MUX2T1_32 addr_out_choose(.s(IorD),
									  .I0(PC_Current[31:0]),
									  .I1(ALU_Out[31:0]),
									  .o(M_addr[31:0])
									  );
						
	REG32 PC(.clk(clk),
				.rst(reset),
				.CE(AND_2_OUT),
				.D(PC_in_data[31:0]),
				.Q(PC_Current[31:0])
				);
				
	//没做中断就不是8T1了
	MUX4T1_32 PC_in_choose(.s(PCSource[1:0]),
								  .I0(res[31:0]),//alu
								  .I1(ALU_Out[31:0]),//branch
								  .I2({PC_Current[31:28],Inst[25:0],2'b00}),//j
								  .I3(ALU_Out[31:0]),//alu
								  .o(PC_in_data[31:0])
								  );
	
	AND2  AND_1(.I0(PCWriteCond),
					.I1(Branch),
					.O(AND_1_out)
					);
					
	OR2   OR_1(.I0(PCWrite),
				  .I1(AND_1_out),
				  .O(OR_1_out)
				 );
				 
	AND2  AND_2(.I0(MIO_ready),
					.I1(OR_1_out),
					.O(AND_2_OUT)
					);
endmodule