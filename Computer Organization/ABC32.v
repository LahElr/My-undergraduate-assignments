`timescale 1ns / 1ps

module ABC32(input wire [31:0]A, 
             input wire [31:0]B, 
             input wire sub, 
             output wire Co, 
             output wire [31:0] S
    );
	wire [31:0] abc_xor_out;
   
   ADC32  abc_adc (.A(A[31:0]), 
                 .B(abc_xor_out[31:0]), 
                 .C0(sub), 
                 .C(S[31:0]), 
                 .Co(Co));
   assign abc_xor_out = ({32{sub}})^B;
endmodule
