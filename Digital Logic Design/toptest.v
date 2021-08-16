`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:38:04 01/05/2020
// Design Name:   Top
// Module Name:   E:/VerilogHDL_DL/MyMaze1/toptest.v
// Project Name:  MyMaze1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module toptest;

	// Inputs
	reg clk;
	reg clrnn;

	// Outputs
	wire [3:0] rr;
	wire [3:0] gg;
	wire [3:0] bb;
	wire hss;
	wire vss;
	wire [3:0] AN;
	wire [7:0] SEGMENT;
	//wire [9:0] x_block;
	//wire [8:0] y_block;

	// Bidirs
	wire [4:0] BTN_X;
	reg [3:0] BTN_Y;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.rr(rr), 
		.gg(gg), 
		.bb(bb), 
		.hss(hss), 
		.vss(vss), 
		.clrnn(clrnn), 
		.BTN_X(BTN_X), 
		.BTN_Y(BTN_Y), 
		.AN(AN), 
		.SEGMENT(SEGMENT)
		//.x_block(x_block), 
		//.y_block(y_block)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clrnn = 1;
		BTN_Y = 15;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here

	end
    
	always #5 clk=~clk;
	 
endmodule

