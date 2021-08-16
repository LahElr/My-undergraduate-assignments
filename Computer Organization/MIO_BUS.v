`timescale 1ns / 1ps

module MIO_BUS(
	input wire clk,
	input wire rst,
	input wire mem_w,
	input wire counter0_out,
	input wire counter1_out,
	input wire counter2_out,
	input wire key_ready,
	input wire [3:0]BTN,
	input wire [4:0]Keys,
	input wire [15:0]SW,
	input wire [15:0]led_out,
	input wire [31:0]addr_bus,
	input wire [31:0]Cpu_data2bus,
	input wire [31:0]ram_data_out,
	input wire [31:0]counter_out,
	
	output reg data_ram_we = 1'b0,
	output reg GPIOf0000000_we = 1'b0,
	output reg GPIOe0000000_we = 1'b0,
	output reg counter_we = 1'b1,
	output reg [11:0]ram_addr, /*从CPU的视角来看要补两个0,地址空间是[3fff,0]*/
	output reg [31:0]Cpu_data4bus,
	output reg [31:0]ram_data_in,
	output reg [31:0]Peripheral_in,
	/*↓vga↓*/
	input wire [11:0]data4vga_ram_a,
	output reg vga_ram_wea,
	output wire [18:0]vga_ram_addra,
	output reg [11:0]data2vga_ram_a
	//output reg KRDY,
	//output reg keys_read_done,
	//output reg key_first
    );
	 
	 parameter RAM = 32'h4000;/*ram上限*/
	 parameter VRAM_1 =  32'hc1ffc;/*图形模式空间下限*/
	 parameter VRAM_2 = 32'h158000;/*图形模式空间上限*/
	 parameter SEG7_1 = 32'hFFFFFE00;
	 parameter SEG7_2 = 32'hE0000000;
	 parameter GPIO_1 = 32'hFFFFFF00;
	 parameter GPIO_2 = 32'hF0000000;
	 parameter Button_1 = 32'hFFFFFC00;
	 parameter Button_2 = 32'hC0000000;
	 parameter Counter_1 = 32'hFFFFFF04;
	 parameter Counter_2 = 32'hF0000004;
	 //ps2没做,是FFFFD000
	 
	 //reg KRDY;
	 //reg keys_read_done;
	 reg [31:0] vga_ram_addra_t;
	 assign vga_ram_addra = vga_ram_addra_t[19:1];
	 
//	 initial begin
//		key_first = 1'b0;
//	   KRDY = 1'b0;
//	 end
	 
	 always@(*)
	 //always@(addr_bus)
	 begin
		data_ram_we = 1'b0;
		GPIOf0000000_we = 1'b0;
		GPIOe0000000_we = 1'b0;
		counter_we = 1'b1;
		ram_addr = 12'b0;
		Cpu_data4bus = 32'h87654321;
		ram_data_in = 32'h12345678;
		Peripheral_in = 32'hbb66bb;
		vga_ram_wea = 1'b0;
		vga_ram_addra_t = 13'b0;
		data2vga_ram_a = 32'h0f00_000f;
		//keys_read_done = 1'b0;
		
			if(addr_bus < RAM)
			begin
				if(mem_w == 1'b1) begin
					ram_data_in = Cpu_data2bus;
					ram_addr = addr_bus[13:2];
					data_ram_we = 1'b1;
				end else begin
					data_ram_we = 1'b0;
					Cpu_data4bus = ram_data_out;
					ram_addr = addr_bus[13:2];
				end
			end else if(addr_bus > VRAM_1 && addr_bus < VRAM_2)
			begin
				if(mem_w == 1'b1) begin
					vga_ram_wea = 1'b1;
					vga_ram_addra_t = addr_bus - 32'h000c_2000;
					data2vga_ram_a = Cpu_data2bus[27:16]; // 32'h 0rgb_0000
				end else begin
					vga_ram_wea = 1'b0;
					vga_ram_addra_t = addr_bus - 32'h000c_2000;
					Cpu_data4bus = {4'b0,data4vga_ram_a,16'b0};
				end
			end else if(addr_bus == SEG7_1 || addr_bus ==SEG7_2)
			begin
				if(mem_w == 1'b1) begin
					GPIOf0000000_we = 1'b0;
					GPIOe0000000_we = 1'b1;
					Peripheral_in = Cpu_data2bus;
				end
			end else if(addr_bus == GPIO_1 || addr_bus == GPIO_2)
			begin
				if(mem_w == 1'b1) begin
					GPIOf0000000_we = 1'b1;
					GPIOe0000000_we = 1'b0;
					Peripheral_in = Cpu_data2bus;
				end else begin
					Cpu_data4bus = {counter0_out, counter1_out, counter2_out, 9'b0, BTN[3:0], SW[15:0]};
				end
			end else if(addr_bus == Button_1 || addr_bus == Button_2)
			begin
				if(mem_w == 1'b0) begin
					//Cpu_data4bus = {KRDY,26'b0/*,BTN*/,Keys};//
					Cpu_data4bus = ({key_ready,26'b0/*,BTN*/,Keys});//
					//keys_read_done = 1'b1;
				end
			end else if(addr_bus == Counter_1 || addr_bus == Counter_2)
			begin
				if(mem_w == 1'b0) begin
					Cpu_data4bus = counter_out;
				end else begin
					GPIOf0000000_we = 1'b0;
					GPIOe0000000_we = 1'b0;
					Peripheral_in = Cpu_data2bus;
				end
			end else begin
				//PASS
			end
	 end
//	 
//	 always@(negedge key_ready or posedge key_ready or negedge keys_read_done) begin
//		if(key_ready == 1'b1 && keys_read_done == 1'b0 && KRDY == 1'b0 && key_first == 1'b0) begin /*posedge key_ready*/
//			KRDY = 1'b1;
//		end else if(key_ready == 1'b1 && keys_read_done == 1'b0 && KRDY == 1'b1 && key_first == 1'b0) begin
//			KRDY = 1'b0;
//			key_first = 1'b1;
//		end else if (key_ready == 1'b0) begin
//			key_first = 1'b0;
//		end
//	 end

endmodule
