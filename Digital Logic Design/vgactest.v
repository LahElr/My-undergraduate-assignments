`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:28:59 01/03/2020
// Design Name:   vgac
// Module Name:   E:/VerilogHDL_DL/MyMaze1/vgactest.v
// Project Name:  MyMaze1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vgac
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vgactest;

	// Inputs
	reg vga_clk;
	reg clrn;
	reg [11:0] d_in;

	// Outputs
	wire [8:0] row_addr;
	wire [9:0] col_addr;
	wire rdn;
	wire [3:0] r;
	wire [3:0] g;
	wire [3:0] b;
	wire hs;
	wire vs;

	// Instantiate the Unit Under Test (UUT)
	vgac uut (
		.vga_clk(vga_clk), 
		.clrn(clrn), 
		.d_in(d_in), 
		.row_addr(row_addr), 
		.col_addr(col_addr), 
		.rdn(rdn), 
		.r(r), 
		.g(g), 
		.b(b), 
		.hs(hs), 
		.vs(vs)
	);

	initial begin
		// Initialize Inputs
		vga_clk = 0;
		clrn = 0;
		d_in = 12'h333;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #5 begin vga_clk=~vga_clk; end
      
endmodule

