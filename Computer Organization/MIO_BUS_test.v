`timescale 1ns / 1ps

module MIO_BUS_test;

	// Inputs
	reg clk;
	reg rst;
	reg mem_w;
	reg counter0_out;
	reg counter1_out;
	reg counter2_out;
	reg key_ready;
	reg [3:0] BTN;
	reg [4:0] Keys;
	reg [15:0] SW;
	reg [15:0] led_out;
	reg [31:0] addr_bus;
	reg [31:0] Cpu_data2bus;
	reg [31:0] ram_data_out;
	reg [31:0] counter_out;
	reg [31:0] data4vga_ram_a;

	// Outputs
	wire data_ram_we;
	wire GPIOf0000000_we;
	wire GPIOe0000000_we;
	wire counter_we;
	wire [11:0] ram_addr;
	wire [31:0] Cpu_data4bus;
	wire [31:0] ram_data_in;
	wire [31:0] Peripheral_in;
	wire vga_ram_wea;
	wire [17:0] vga_ram_addra;
	wire [31:0] data2vga_ram_a;

	// Instantiate the Unit Under Test (UUT)
	MIO_BUS uut (
		.clk(clk), 
		.rst(rst), 
		.mem_w(mem_w), 
		.counter0_out(counter0_out), 
		.counter1_out(counter1_out), 
		.counter2_out(counter2_out), 
		.key_ready(key_ready), 
		.BTN(BTN), 
		.Keys(Keys), 
		.SW(SW), 
		.led_out(led_out), 
		.addr_bus(addr_bus), 
		.Cpu_data2bus(Cpu_data2bus), 
		.ram_data_out(ram_data_out), 
		.counter_out(counter_out), 
		.data_ram_we(data_ram_we), 
		.GPIOf0000000_we(GPIOf0000000_we), 
		.GPIOe0000000_we(GPIOe0000000_we), 
		.counter_we(counter_we), 
		.ram_addr(ram_addr), 
		.Cpu_data4bus(Cpu_data4bus), 
		.ram_data_in(ram_data_in), 
		.Peripheral_in(Peripheral_in), 
		.data4vga_ram_a(data4vga_ram_a), 
		.vga_ram_wea(vga_ram_wea), 
		.vga_ram_addra(vga_ram_addra), 
		.data2vga_ram_a(data2vga_ram_a)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		mem_w = 0;
		counter0_out = 0;
		counter1_out = 0;
		counter2_out = 0;
		key_ready = 0;
		BTN = 0;
		Keys = 0;
		SW = 0;
		led_out = 0;
		addr_bus = 0;
		Cpu_data2bus = 0;
		ram_data_out = 0;
		counter_out = 0;
		data4vga_ram_a = 0;

		// Wait 100 ns for global reset to finish
		#30;
		rst = 0;
		mem_w = 1;
		addr_bus = 12;
		Cpu_data2bus = 4;
        
		// Add stimulus here

	end
	
	always #20 begin
		clk = ~clk;
	end
      
endmodule

