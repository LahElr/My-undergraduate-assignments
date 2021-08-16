`timescale 1ns / 1ps
module Regs(
input wire clk,
input wire rst,
input wire L_S,
input wire [4:0] R_addr_A,R_addr_B,Wt_addr,
input wire [31:0] Wt_data,
output wire [31:0] rdata_A,rdata_B
    );
	reg [31:0] regs [0:31];
	//reg [31:0] regs [1:31];
	
	//assign rdata_A = (R_addr_A == 0)? 0 : regs[R_addr_A];
	//assign rdata_B = (R_addr_A == 0)? 0 : regs[R_addr_B];
	
	assign rdata_A = regs[R_addr_A];
	assign rdata_B = regs[R_addr_B];
	
	initial begin
		regs[0] <= 0;
	end
	
	always@(posedge clk or posedge rst)
	begin
		if(rst == 1)
		begin
			regs[0] <= 0;
			regs[1] <= 0;
			regs[2] <= 0;
			regs[3] <= 0;
			regs[4] <= 0;
			regs[5] <= 0;
			regs[6] <= 0;
			regs[7] <= 0;
			regs[8] <= 0;
			regs[9] <= 0;
			regs[10] <= 0;
			regs[11] <= 0;
			regs[12] <= 0;
			regs[13] <= 0;
			regs[14] <= 0;
			regs[15] <= 0;
			regs[16] <= 0;
			regs[17] <= 0;
			regs[18] <= 0;
			regs[19] <= 0;
			regs[20] <= 0;
			regs[21] <= 0;
			regs[22] <= 0;
			regs[23] <= 0;
			regs[24] <= 0;
			regs[25] <= 0;
			regs[26] <= 0;
			regs[27] <= 0;
			regs[28] <= 0;
			regs[29] <= 0;
			regs[30] <= 0;
			regs[31] <= 0;
		end
		else if(/*(Wt_addr != 0) && */(L_S == 1) ) //L_S == 1
		begin
			regs[Wt_addr] <= Wt_data;
		end
	end
			
	
endmodule
