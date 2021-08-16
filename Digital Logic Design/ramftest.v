`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:03:23 01/07/2020
// Design Name:   RAM_f
// Module Name:   E:/VerilogHDL_DL/MyMaze2/ramftest.v
// Project Name:  MyMaze2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RAM_f
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ramftest;

	// Inputs
	reg clk;
	reg [0:0] wea;
	reg [8:0] addra;
	reg [15:0] dina;
	//reg clkb;
	reg [0:0] web;
	reg [8:0] addrb;
	reg [15:0] dinb;

	// Outputs
	wire [15:0] douta;
	wire [15:0] doutb;

	// Instantiate the Unit Under Test (UUT)
	RAM_f uut (
		.clka(clk), 
		.wea(wea), 
		.addra(addra), 
		.dina(dina), 
		.douta(douta), 
		.clkb(clk), 
		.web(web), 
		.addrb(addrb), 
		.dinb(dinb), 
		.doutb(doutb)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		wea = 0;
		addra = 0;
		dina = 0;
		//clkb = 0;
		web = 0;
		addrb = 0;
		dinb = 0;

		// Wait 100 ns for global reset to finish
		
        
		// Add stimulus here

	end
    
	always #5 clk=~clk;
	
	always #7 addra = addra+1;
	 
endmodule

