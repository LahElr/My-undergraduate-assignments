`timescale 1ns / 1ps

module VGA_BUS(
	input wire [8:0] row_addr,
	input wire [9:0] col_addr,
	//input wire [12:0] data_from_vga_ram,
	
	//output wire [11:0] data_to_vgac,
	output wire [18:0] vga_ram_addr
    );
	 
	 assign vga_ram_addr = row_addr*10'd640+col_addr;
	 
	 /*wire [15:0] data_to_vgac_wide;
	 assign data_to_vgac_wide = (vgac_addr[0]==1'b1)?(data_from_vga_ram[31:16]):(data_from_vga_ram[15:0]);
	 assign data_to_vgac = data_to_vgac_wide[11:0];*/

endmodule
