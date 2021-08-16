`timescale 1ns / 1ps

module alu(input [31:0]A, 
           input [31:0]B, 
           input [3:0]ALU_Ctrl, 

           output overflow, 
           output [31:0]res, 
           output zero,
			  output Co
			  );
   
   wire [31:0] ABC32_out;
   wire [31:0] and32_out;
   wire [31:0] or32_out;
   wire [31:0] xor32_out;
   wire [31:0] nor32_out;
   wire [31:0] srl32_out;
	wire [31:0] sra32_out;
	wire [31:0] sll32_out;
	wire or_bit_32_out;
   
   /*
   and32  alu_and32 (.A(A[31:0]), 
                    .B(B[31:0]), 
                    .res(and32_out[31:0]));
   or32  alu_or32 (.A(A[31:0]), 
                  .B(B[31:0]), 
                  .res(or32_out[31:0]));						 
   xor32  alu_xor32 (.A(A[31:0]), 
                    .B(B[31:0]), 
                    .res(xor32_out[31:0]));
   nor32  alu_nor32 (.A(A[31:0]), 
                    .B(B[31:0]), 
                    .res(nor32_out[31:0]));
	*/
	ABC32  alu_abc32 (.A(A[31:0]), 
                    .B(B[31:0]), 
                    .sub(ALU_Ctrl[2]), 
                    .Co(Co), 
                    .S(ABC32_out[31:0]));
	assign and32_out = A&B;
	assign or32_out = A|B;
	assign nor32_out = ~(A|B);
	assign xor32_out = A^B;
   srl32  alu_srl32 (.A(A[31:0]), 
                    .B(B[31:0]), 
                    .res(srl32_out[31:0]));

   sll32 alu_sll32(.A(A[31:0]), 
                    .B(B[31:0]), 
                    .res(sll32_out[31:0]));
						  
   sra32 alu_sra32(.A(A[31:0]), 
                    .B(B[31:0]), 
                    .res(sra32_out[31:0]));

   MUX16T1_32  alu_MUX16T1_32 (.I0(and32_out[31:0]), 
                            .I1(or32_out[31:0]), 
                            .I2(ABC32_out[31:0]), 
                            .I3(xor32_out[31:0]), 
                            .I4(nor32_out[31:0]), 
                            .I5(srl32_out[31:0]), 
                            .I6(ABC32_out[31:0]), 
									 //.I7((a < b)?32'b1:32'b0),
                            .I7({31'b0,ABC32_out[31]}),
									 .I8(sll32_out),
									 .I9(sra32_out),
									 .I10(A<B),
									 .I11(A+B),
									 .I12(A-B),
									 .I13(32'b0),
									 .I14(32'b0),
									 .I15(32'hf1e20a3b),
                            .s(ALU_Ctrl),
                            .o(res[31:0]));
					
	is_overflow alu_is_overflow(.signOp1(A[31]),
										 .signOp2(B[31]),
										 .signRes(res[31]),
										 .ALUsel(ALU_Ctrl),
										 .overflow(overflow));
										 
	or_bit_32 alu_or_bit_32(.A(res),.O(zero));
endmodule
