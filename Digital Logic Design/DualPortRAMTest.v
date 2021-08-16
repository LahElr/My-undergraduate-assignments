`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:28:00 01/04/2020
// Design Name:   RAM_e
// Module Name:   E:/VerilogHDL_DL/MyMaze1/DualPortRAMTest.v
// Project Name:  MyMaze1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RAM_e
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DualPortRAMTest;

	// Inputs
	//reg clka;
	reg [0:0] wea;
	reg [8:0] addra;
	reg [15:0] dina;
	reg clk;
	reg [0:0] web;
	reg [8:0] addrb;
	reg [15:0] dinb;

	// Outputs
	wire [15:0] douta;
	wire [15:0] doutb;

	// Instantiate the Unit Under Test (UUT)
	RAM_e uut (
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
		//clka = 0;
		wea = 0;
		addra = 0;
		dina = 0;
		clk = 0;
		web = 0;
		addrb = 0;
		dinb = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #5 begin clk=~clk; end
	
	always #5 begin addrb <= addrb+1; end
	
      
endmodule

