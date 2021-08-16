module top
(
	input wire RSTN,
	input wire [3:0] K_COL,
	output wire [4:0] K_ROW,
	input wire [15:0] SW,
	input wire clk_100mhz,
	
	output wire CR,
	output wire RDY,
	output wire readn,
	
	output wire SEGCLK,
	output wire SEGDT,
	output wire SEGEN,
	output wire SEGCLR,
	
	output wire LEDCLK,
	output wire LEDDT,
	output wire LEDEN,
	output wire LEDCLR,
	
	output wire [7:0] SEGMENT,
	output wire [3:0] AN,
	output wire [7:0] LED,
	
	output wire [3:0] rr,
	output wire [3:0] gg,
	output wire [3:0] bb,
	output wire hss,
	output wire vss
);

   wire [31:0] Addr_out;
   wire [31:0] Ai;
   wire [31:0] Bi;
   wire [7:0] blink;
   wire [3:0] BTN_OK;
   wire Clk_CPU;
   wire [1:0] counter_ch;
   wire [31:0] Counter_out;
   wire counter_we;
   wire counter0_out;
   wire counter1_out;
   wire counter2_out;
   wire [31:0] CPU2IO;
   wire [31:0] Data_in;
   wire [31:0] Data_out;
   wire data_ram_we;
   wire [31:0] Disp_num;
   wire [31:0] Div;
   wire GPIOe0000000_we;
   wire GPIOF0;
   wire [31:0] inst;
   wire IO_clk;
   wire [4:0] Key_out;
   wire [15:0] LED_out;
   wire [7:0] LE_out;
   wire mem_w;
   wire N0;
   wire [31:0] PC;
   wire [7:0] point_out;
   wire [3:0] Pulse;
   wire [11:0] ram_addr;
   wire [31:0] ram_data_in;
   wire [31:0] ram_data_out;
   wire rst;
   wire [15:0] SW_OK;
   wire V5;
   wire RDY_DUMMY;
   wire readn_DUMMY;
   wire [4:0] state;
	
   assign RDY = RDY_DUMMY;
   assign readn = readn_DUMMY;
	
	wire [11:0] data4vga_ram_a_;
	wire vga_ram_wea_;
	wire [18:0] vga_ram_addra_;
	wire [11:0] data2vga_ram_a_;
					 
	wire [11:0] vgac_d_in;
	wire [8:0] rad;
	wire [9:0] cad;
	//wire [18:0] vga_ram_addr4bus;
	reg [18:0] vga_ram_addr4bus;
	
	//wire KRDY;
	//wire keys_read_done,key_first;
	//wire [31:0] data_from_vga_ram_2bus;
	
   SEnter_2_32  M4 (.BTN(BTN_OK[2:0]), 
                   .clk(clk_100mhz), 
                   .Ctrl({SW_OK[7:5], SW_OK[15], SW_OK[0]}), 
                   .Din(Key_out[4:0]), 
                   .D_ready(RDY_DUMMY), 
                   .Ai(Ai[31:0]), 
                   .Bi(Bi[31:0]), 
                   .blink(blink[7:0]), 
                   .readn(readn_DUMMY));
	SAnti_jitter  U9 (.clk(clk_100mhz), 
                   .Key_y(K_COL[3:0]), 
                   .readn(readn_DUMMY), 
                   .RSTN(RSTN), 
                   .SW(SW[15:0]), 
                   .BTN_OK(BTN_OK[3:0]), 
                   .CR(CR), 
                   .Key_out(Key_out[4:0]), 
                   .Key_ready(RDY_DUMMY), 
                   .Key_x(K_ROW[4:0]), 
                   .pulse_out(Pulse[3:0]), 
                   .rst(rst), 
                   .SW_OK(SW_OK[15:0]));
   MCPU  U1 (.clk(Clk_CPU), 
				//.clk(SW_OK[14]), 
            .Data_in(Data_in[31:0]), 
            .inst_out(inst[31:0]), 
            .INT(counter0_out), 
            .MIO_ready(V5), 
            .reset(rst), 
            .Addr_out(Addr_out[31:0]), 
            .CPU_MIO(), 
            .Data_out(Data_out[31:0]), 
            .PC_out(PC[31:0]), 
            .mem_w(mem_w),
				.state(state[4:0]));
   RAM_B  U3 (.addra(ram_addr[11:0]), 
             .clka(clk_100mhz), 
             .dina(ram_data_in[31:0]), 
             .wea(data_ram_we), 
             .douta(ram_data_out[31:0]));
   MIO_BUS  U4 (.rst(rst),
					.clk(clk_100mhz), 
					.mem_w(mem_w), 
					.counter0_out(counter0_out), 
               .counter1_out(counter1_out), 
               .counter2_out(counter2_out), 
					.key_ready(RDY_DUMMY),
					.BTN(BTN_OK[3:0]), 
					.Keys(Key_out[4:0]),
					.SW(SW_OK[15:0]), 
					.led_out(LED_out[15:0]), 
					.addr_bus(Addr_out[31:0]), 
					.Cpu_data2bus(Data_out[31:0]),
					.ram_data_out(ram_data_out[31:0]), 
               .counter_out(Counter_out[31:0]), 
					
               .data_ram_we(data_ram_we), 
					.GPIOe0000000_we(GPIOe0000000_we), 
               .GPIOf0000000_we(GPIOF0), 
					.counter_we(counter_we), 
					.ram_addr(ram_addr[11:0]), 
               .Cpu_data4bus(Data_in[31:0]), 
					.ram_data_in(ram_data_in[31:0]),
               .Peripheral_in(CPU2IO[31:0]), 
               
					.data4vga_ram_a(data4vga_ram_a_),
					.vga_ram_wea(vga_ram_wea_),
					.vga_ram_addra(vga_ram_addra_),
					.data2vga_ram_a(data2vga_ram_a_)
					//.KRDY(KRDY),
					//.keys_read_done(keys_read_done),
					//.key_first(key_first)
					);
   DSEGIO  U5 (.clk(IO_clk), 
              .Data0(CPU2IO[31:0]), 
              .data1({N0, N0, PC[31:2]}), 
              .data2(inst[31:0]), 
              .data3(Counter_out[31:0]), 
              .data4(Addr_out[31:0]), 
              //.data5(Data_out[31:0]), 
              //.data5({20'b0,vgac_d_in}), 
              //.data5({4'b0,rr,gg,bb,4'b0,rr,gg,bb}), 
              .data5({RDY_DUMMY,22'b0,BTN_OK,Key_out}), 
              .data6(Data_in[31:0]), 
              .data7(PC[31:0]), 
              .EN(GPIOe0000000_we), 
              .LES({N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
						  N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
						  N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, 
						  N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0, N0}), 
              .point_in({Div[31:0], Div[31:0]}), 
              .rst(rst),
              .Test(SW_OK[7:5]), 
              .Disp_num(Disp_num[31:0]), 
              .LE_out(LE_out[7:0]), 
              .point_out(point_out[7:0]));
   Display  U6 (.clk(clk_100mhz), 
               .flash(Div[25]), 
               .Hexs(Disp_num[31:0]), 
               .LES(LE_out[7:0]), 
               .mapup(), 
               .point(point_out[7:0]), 
               .rst(rst), 
               .Start(Div[20]), 
               .Text(SW_OK[0]), 
               .seg_clk(SEGCLK), 
               .seg_clrn(SEGCLR), 
               .SEG_PEN(SEGEN), 
               .seg_sout(SEGDT));
   GPIO  U7 (.clk(IO_clk), 
            .EN(GPIOF0), 
            .P_Data(CPU2IO[31:0]), 
            .rst(rst), 
            .Start(Div[20]), 
            .counter_set(counter_ch[1:0]), 
            .GPIOf0(), 
            .led_clk(LEDCLK), 
            .led_clrn(LEDCLR), 
            .LED_out(LED_out[15:0]), 
            .LED_PEN(LEDEN), 
            .led_sout(LEDDT));
   clk_div  U8 (.clk(clk_100mhz), 
               .rst(rst), 
               .STEP(SW_OK[2]), 
               .clkdiv(Div[31:0]),
               .Clk_CPU(Clk_CPU)
					);

   Counter  U10 (.clk(IO_clk), 
                .clk0(Div[6]), 
                .clk1(Div[9]), 
                .clk2(Div[11]), 
                .counter_ch(counter_ch[1:0]), 
                .counter_val(CPU2IO[31:0]), 
                .counter_we(counter_we), 
                .rst(rst), 
                .counter_out(Counter_out[31:0]), 
                .counter0_OUT(counter0_out), 
                .counter1_OUT(counter1_out), 
                .counter2_OUT(counter2_out));
   Disp2Hex  U61 (.flash(Div[25]), 
                 .Hexs(Disp_num[31:0]), 
                 .LES(LE_out[7:0]), 
                 .points(point_out[7:0]), 
                 .Scan({SW_OK[1], Div[19:18]}), 
                 .Text(SW_OK[0]), 
                 .AN(AN[3:0]), 
                 .SEGMENT(SEGMENT[7:0]));
   PIO  U71 (.clk(IO_clk), 
            .EN(GPIOF0), 
            .PData_in(CPU2IO[31:0]), 
            .rst(rst), 
            .counter_set(), 
            .GPIOf0(), 
            .LED_out(LED[7:0]));
   VCC  U_VCC (.P(V5));
   GND  U_GND (.G(N0));
   INV  U_INV1 (.I(Clk_CPU), 
                .O(IO_clk));
	
	
	//changed:just a multiplexer
//	VGA_BUS U_VGA_C(.row_addr(rad),
//						 .col_addr(cad),
//						 //.data_from_vga_ram(data_from_vga_ram_2bus),
//						 //.data_to_vgac(vgac_d_in),
//						 .vga_ram_addr(vga_ram_addr4bus));
	
//输出的颜色对应就是反的，因为它输进去是按照低位到高位rgb的顺序的,但vga_ram里是反过来
	vgac vga_out(.d_in(vgac_d_in),
			.vga_clk(Div[1]),
			.clrn(1'b1),
			.row_addr(rad),
			.col_addr(cad),
			.r(bb[3:0]),
			.g(gg[3:0]),
			.b(rr[3:0]),
			.hs(hss),
			.vs(vss));
	//assign vga_ram_addr4bus = rad*10'd640+cad;
	//always@(rad or cad) begin
	always@(negedge clk_100mhz) begin
		vga_ram_addr4bus = rad*10'd640+cad;
	end
	
	RAM_C vga_ram(.clka(clk_100mhz),
					  .wea(vga_ram_wea_),
					  .addra(vga_ram_addra_),
					  .dina(data2vga_ram_a_),
					  .douta(data4vga_ram_a_),
					  .clkb(clk_100mhz),
					  .web(1'b0),
					  .addrb(vga_ram_addr4bus),
					  .dinb(32'h0f0f_00f0),
					  //.doutb(data_from_vga_ram_2bus)
					  .doutb(vgac_d_in)
					  );
endmodule