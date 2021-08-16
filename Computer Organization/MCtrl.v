`timescale 1ns / 1ps

module MCtrl
(
	input wire clk,
	input wire reset,
	input wire zero,
	input wire overflow,
	input wire MIO_ready,
	input wire [31:0] Inst_in,
	
	output reg MemRead = 0,
	output reg sign = 0,
	output reg MemWrite = 0,
	output reg CPU_MIO = 0,
	output reg IorD = 0,
	output reg IRWrite = 0,
	output reg RegWrite = 0,
	output reg PCWrite = 0,
	output reg PCWriteCond = 0,
	output reg Branch = 0,
	output reg [1:0] RegDst = 0,
	output reg [1:0] MemtoReg = 0,
	output reg [1:0] ALUSrcB = 0,
	output reg [1:0] ALUSrcA = 2'b00,
	output reg [1:0] PCSource = 0,
	output reg [3:0] ALU_operation = 0,
	output reg [4:0] state_out = 5'b00000
);
parameter IF = 5'b00000; //取指
parameter ID = 5'b00001; //解析
parameter MAC = 5'b00010; //sw || lw
parameter MAR = 5'b00011; //lw
parameter WB = 5'b00100; //write back
parameter MAW = 5'b00101; //sw
parameter EXE = 5'b00110; //r执行
parameter RTYPE = 5'b00111; //r-type-return
parameter BR = 5'b01000; //branch
parameter J = 5'b01001; //j
parameter JAL = 5'b01010; //jal
parameter JR = 5'b01011; //jr
parameter EXEI = 5'b01100; //i执行
parameter LUI = 5'b01101; //lui
parameter RTYPEI = 5'b01110; //i-type-return

always @(*) 
begin
	MemRead = 1'b0;
	MemWrite = 1'b0;
	CPU_MIO = 1'b0;
	IorD = 1'b0;
	IRWrite = 1'b0;
	RegWrite = 1'b0;
	ALUSrcA = 2'b00;
	PCWrite = 1'b0;
	PCWriteCond = 1'b0;
	Branch = 1'b0;
	RegDst = 2'b00;
	MemtoReg = 2'b00;
	ALUSrcB = 2'b00;
	PCSource = 2'b00;
	ALU_operation = 4'b0000;
	sign = 1'b0;
	
	if (MIO_ready == 1 && reset == 0)
	begin
	
	case (state_out)
	
		IF:
		begin
			MemRead = 1'b1;//
			IorD = 1'b0;//
			IRWrite = 1'b1;//
			ALUSrcA = 2'b00;//
			PCWrite = 1'b1;//
			ALUSrcB = 2'b01;//
			PCSource = 2'b00;	//	
			ALU_operation = 4'b0010;//
		end
	
		ID :
		begin
			ALUSrcA = 2'b00;//
			ALUSrcB = 2'b11;//
			ALU_operation = 4'b0010;//
			RegDst = 2'b11;//
			sign = 1;
		end
		
		MAC :
		begin
			ALUSrcA = 2'b01;//
			ALUSrcB = 2'b10;//
			ALU_operation = 4'b0010;//	
		end
		
		MAR :
		begin
			RegDst = 2'b11;
			MemRead = 1'b1;//
			IorD = 1'b1;//
		end
		
		WB :
		begin
			RegWrite = 1'b1;//
			RegDst = 2'b00;//
			MemtoReg = 2'b01;//
		end
		
		MAW :
		begin
			MemRead = 1'b0;//
			MemWrite = 1'b1;//
			IorD = 1'b1;//
		end
		
		EXE :
		begin
			ALUSrcB = 2'b00;//
			RegDst = 2'b11;
			case (Inst_in[5:0])
				6'b100000 : begin ALU_operation = 4'b0010; ALUSrcA = 2'b01; end//add-2
				6'b100010 :	begin ALU_operation = 4'b0110; ALUSrcA = 2'b01; end//sub-6
				6'b100100 :	begin ALU_operation = 4'b0000; ALUSrcA = 2'b01; end//and-0
				6'b100101 :	begin ALU_operation = 4'b0001; ALUSrcA = 2'b01; end//or-1
				6'b101010 :	begin ALU_operation = 4'b0111; ALUSrcA = 2'b01; end//slt-7
				6'b100111 :	begin ALU_operation = 4'b0100; ALUSrcA = 2'b01; end//nor-4
				6'b100110 : begin ALU_operation = 4'b0011; ALUSrcA = 2'b01; end//xor-3
				6'b000010 : begin ALU_operation = 4'b0101; ALUSrcA = 2'b10; end//srl-5
				6'b000000 : begin ALU_operation = 4'b1000; ALUSrcA = 2'b10; end//sll-8
				6'b000011 : begin ALU_operation = 4'b1001; ALUSrcA = 2'b10; end//sra-9
				6'b001000 : begin ALU_operation = 4'b0010; ALUSrcA = 2'b01; end//add-2 for jr
				6'b000110 : begin ALU_operation = 4'b0101; ALUSrcA = 2'b01; end//srlv-5
				6'b000111 : begin ALU_operation = 4'b1001; ALUSrcA = 2'b01; end//srav-9
				6'b000100 : begin ALU_operation = 4'b1000; ALUSrcA = 2'b01; end//sllv-8
				default : begin ALU_operation = 4'b1000;  ALUSrcA = 2'b01; end//sll-8
			endcase
		end
		
		LUI:
		begin
			RegWrite = 1'b1;//
			RegDst = 2'b00;//
			MemtoReg = 2'b10;//
		end
		
		JAL:
		begin
			PCWrite = 1'b1;//
			PCSource = 2'b10;//
			RegWrite = 1'b1;//
			RegDst = 2'b10;//
			MemtoReg = 2'b11;//
		end
		
		JR:
		begin
			PCWrite = 1'b1;//
			PCSource = 2'b11;//
		end
		
		EXEI :
		begin
			ALUSrcA = 2'b01;//
			ALUSrcB = 2'b10;//
			RegDst = 2'b11;
			case (Inst_in[31:26])
				6'b001000 : begin ALU_operation = 4'b0010; sign = 1; end//addi
				6'b001100 : begin ALU_operation = 4'b0000; sign = 0; end//andi
				6'b001101 : begin ALU_operation = 4'b0001; sign = 0; end//ori
				6'b001010 : begin ALU_operation = 4'b0111; sign = 1; end//slti
				6'b001110 : begin ALU_operation = 4'b0011; sign = 0; end//xori
				default : begin ALU_operation = 4'b1000; sign = 0; end//sll
			endcase
		end
			
		RTYPE :
		begin
			RegWrite = 1'b1;//
			RegDst = 2'b01;//
			MemtoReg = 2'b00;//
		end
		
		RTYPEI :
		begin
			RegWrite = 1'b1;//
			RegDst = 2'b00;//
			MemtoReg = 2'b00;//
		end
		
		BR :
		begin
			if ((zero == 1'b1 && Inst_in[31:26] == 6'b000100) || (zero == 1'b0 && Inst_in[31:26] == 6'b000101))
				PCWriteCond = 1'b1;//
			ALUSrcA = 2'b01;//
			ALUSrcB = 2'b00;//
			ALU_operation = 4'b0110;//
			Branch = 1'b1;//	
			PCSource = 2'b01;
			sign = 1;
		end
		
		J :
		begin
			PCWrite = 1'b1;//
			PCSource = 2'b10;//
		end
	endcase
	
	end
end

always @(posedge clk or posedge reset) 
begin
	if (reset == 1'b1)
		state_out = 5'b00000;
	else if (MIO_ready == 1'b1)
	begin
		case (state_out)
		IF:
			state_out = ID;//
		
		ID:
		begin
			case (Inst_in[31:26])
				6'b000000 : state_out = EXE;//R
				6'b100011 : state_out = MAC;//lw
				6'b101011 : state_out = MAC;//sw
				6'b000010 : state_out = J;//j
				6'b000100 : state_out = BR;//beq
				6'b000101 : state_out = BR;//bne
				6'b001000 : state_out = EXEI;//addi
				6'b001100 : state_out = EXEI;//andi
				6'b001101 : state_out = EXEI;//ori
				6'b001010 : state_out = EXEI;//slti
				6'b001110 : state_out = EXEI;//xori
				6'b001111 : state_out = LUI;//lui
				6'b000011 : state_out = JAL;//jal
				default : state_out = IF;
			endcase
		end
		
		
		MAC:
		begin
			case (Inst_in[29])
				1'b1 : state_out = MAW;
				1'b0 : state_out = MAR;
			endcase
		end
		
		MAR:
			state_out = WB;//		
		
		WB:
			state_out = IF;//

		MAW:
			state_out = IF;

		EXE:
			if (Inst_in[5:0] == 6'b001000)
				state_out = JR;
			else
				state_out = RTYPE;
			
		EXEI:
			state_out = RTYPEI;
		
		RTYPE:
			state_out = IF;
		
		RTYPEI:
			state_out = IF;
		
		BR:
			state_out = IF;

		J:
			state_out = IF;
		
		JR:
			state_out = IF;
		
		JAL:
			state_out = IF;
		
		LUI:
			state_out = IF;
		endcase
	end
end
endmodule