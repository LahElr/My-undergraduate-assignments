`timescale 1ns / 1ps
module Top(
	input wire clk,//clock
	output wire [3:0] rr,//red
	output wire [3:0] gg,//green
	output wire [3:0] bb,//blue
	output wire hss,//horizental scan
	output wire vss,//vertical scan
	input wire clrnn,//clear,1 : clear all regs and show the cover
	output wire [3:0]AN,
	output wire [7:0]SEGMENT,
	input wire PS2_clk,
	input wire PS2_data
    );
	
	//parameters
	parameter wall_color = 12'h216;//The color of wall is RGB#601020
	parameter radius = 7'b1010010;//The radius of view is 7'd82

	//Variables

	wire [31:0]clkdiv;//clock division signal
	
	//About memory and showing
	wire [11:0] datao;
	reg [11:0] show_data;//what color to draw for the pixel we see now
	wire [11:0] datao_pic;//the out of the rom of background picture
	wire [11:0] datao_start;//the out of the rom of cover picture
	wire [11:0] datao_died;//the out of the rom of dead picture
	wire [11:0] datao_heart;//the out of the rom of player icon
	wire [15:0] datao_map;//the out of the rom of map:the first one
	wire [15:0] datao_map_b;//the out of the rom of map:the second one
	
	wire [8:0] rad;//y coordinate of the pixel now drawing
	wire [9:0] cad;//y coordinate of the pixel now drawing
	reg [18:0] pic_addr;//the address of the rom of background picture
	reg [10:0] heart_addr;//the address of the rom of player icon
	reg [8:0] map_addr;//the address of the rom of map:the first one
	reg [8:0] map_addr_w;//the address of the rom of map:the second one
	
	//USB-keyboard
	wire [9:0] keys;//key code inputed
	wire PS2_ready;
	reg PS2_was_ready;
	reg PS2_moved;
	
	//About player,view and trick
	reg [3:0] x_block;//x coordinate of player in blocks
	reg [3:0] y_block;//y coordinate of player in blocks
	wire [9:0] x_pixel;//x coordinate of player in pixels
	wire [8:0] y_pixel;//y coordinate of player in pixels
	wire [19:0] x_square;
	wire [19:0] y_square;
	wire [19:0] r_square;
	reg trick_used;//trick noted 1 is used
	reg [1:0] dir_rec;//enum{left,right,down,up};
	reg bounced;//bounced_on_wall This reg exists in order the bouncing happens for many times
	reg [4:0] tricked;//14,81,e5,d6,79
	
	//About the game flow
	reg [1:0] finished;//enum{not_finished,won,dead,un-started};
	reg reset;//if it is reseting (and showing the cover
	
	//About the judgement if it is wall or road
	wire is_wall;//if the player is on wall
	wire is_road;//if the player is on road
	wire is_wall_b;//if the pixel now showing is wall
	wire is_road_b;//if the pixel now showing is road
	
	//initializaion
	initial begin
	trick_used <= 1'b0;
	x_block <= 4'h3;
	y_block <= 4'h2;
	show_data<=12'b0;
	pic_addr<=19'b0;
	heart_addr <= 11'b0;
	map_addr <= 9'b0;
	wasReady<=1'b0;
	dir_rec <= 2'b1;
	finished <= 2'b11;
	map_addr_w <= x_block * 5'd16 + y_block;
	bounced<=1'b0;
	tricked <= 5'd00000;
	PS2_moved <= 1'b0;
	end
	
	clkdiv cd(.clk(clk),.rst(1'b0),.clkdiv(clkdiv));
	disp_num dnm(.clk(clk),.HEXS({datao_map[3:0],datao_map_b[3:0],y_block,x_block}),.LES(4'b0000),.point(clkdiv[29:26]),.RST(1'b0),.AN(AN),.Segment(SEGMENT));//7-seg led show:what block is the pixel now drawing belongs to,what block layer now standing,x and y coordinate of the playeer
	RAM_b pic(.clka(clk),.wea(1'b0),.addra(pic_addr),.dina(12'h123),.douta(datao_pic));//ROM of background picture
	RAM_c heart(.clka(clk),.wea(1'b0),.addra(heart_addr),.dina(12'h123),.douta(datao_heart));//ROM of player icon
	RAM_g map(.clka(clk),.wea(1'b0),.addra(map_addr_w),.dina(16'haaaa),.douta(datao_map_b),.clkb(clk),.web(1'b0	),.addrb(map_addr),.dinb(16'hbbbb),.doutb(datao_map));//TRUE DUAL PORT ROM of map
	rom_start start(.clka(clk),.addra(pic_addr),.douta(datao_start));//ROM of cover picture
	ROM_die die(.clka(clk),.addra(pic_addr),.douta(datao_died));//ROM of dead picture

	vgac vac(.vga_clk(clkdiv[1]),.clrn(1'b1),.d_in(show_data),.row_addr(rad),.col_addr(cad),.r(rr[3:0]),.g(gg[3:0]),.b(bb[3:0]),.hs(hss),.vs(vss));//showing module
	//Keypad k0 (.clk(clkdiv[15]), .keyX(BTN_Y), .keyY(BTN_X), .keyCode(keyCode), .ready(keyReady));
	ps2_ver2 m0(.clk(clk),.rst(1'b1),.ps2_clk(PS2_clk),.ps2_data(PS2_data),.data_out(keys[7:0]),.ready(PS2_ready));//USB-Keyboard
	
	assign x_pixel = x_block*6'd40+5'd20;
	assign y_pixel = y_block*6'd40+5'd20;
	assign x_square = (x_pixel - cad) * (x_pixel - cad);
	assign y_square = (y_pixel - rad) * (y_pixel - rad);
	assign r_square = radius * radius;
	assign is_wall = (datao_map_b === 16'h0000 || (datao_map_b === 16'h1414 && tricked[4] === 1'b1) || (datao_map_b === 16'h14e5 && tricked[2] === 1'b1) || (datao_map_b === 16'h14d6 && tricked[1] === 1'b1) || (datao_map_b === 16'h1479 && tricked[0] === 1'b1));
	assign is_road = (datao_map_b === 16'h0001 || (datao_map_b === 16'h1581 && tricked[3] === 1'b1));
	assign is_wall_b = (datao_map === 16'h0000 || (datao_map === 16'h1414 && tricked[4] === 1'b1) || (datao_map === 16'h14e5 && tricked[2] === 1'b1) || (datao_map === 16'h14d6 && tricked[1] === 1'b1) || (datao_map === 16'h1479 && tricked[0] === 1'b1) || (datao_map === 16'h1581 && tricked[3] === 1'b0));
	assign is_road_b = (datao_map === 16'h0001 || (datao_map === 16'h1581 && tricked[3] === 1'b1) || (datao_map === 16'h1414 && tricked[4] === 1'b0) || (datao_map === 16'h14e5 && tricked[2] === 1'b0) || (datao_map === 16'h14d6 && tricked[1] === 1'b0) || (datao_map === 16'h1479 && tricked[0] === 1'b0) || (datao_map > 16'h0fff && datao_map < 16'h1fff));
	
	always @ (posedge clk) begin
		if(!clrnn) begin /*re-initialization and show the cover*/
			map_addr_w <=y_block * 5'd16 + x_block;
			finished <= 2'b11;
			tricked <= 5'd00000;
			trick_used <= 1'b0;
		end else begin
			if(!reset) begin
				finished <= 2'b00;//show cover
			end
					map_addr_w <= y_block * 5'd16 + x_block;
					
					if (datao_map_b === 16'h0003) begin
						finished <=2'b11;//finished
					end else if (datao_map_b === 16'h0002) begin
						finished <=2'b10;//dead
					end else if(datao_map_b > 16'h0fff && datao_map_b < 16'h1fff) begin /*is trick*/
						if(datao_map_b[11:8] === 4'h1 && trick_used === 1'b0) begin /*chain trick not used*/
							trick_used <= 1'b1;
							case (datao_map_b[7:0])
								8'h14:begin tricked[4] <= 1'b1; end
								8'h81:begin tricked[3] <= 1'b1; end
								8'he5:begin tricked[2] <= 1'b1; end
								8'hd6:begin tricked[1] <= 1'b1; end
								8'h79:begin tricked[0] <= 1'b1; end
								default:begin end
							endcase
						end else if(datao_map_b[11:8] === 4'h1 && trick_used === 1'b1) begin /*chain trick used*/
						end else if(datao_map_b[11:8] === 4'h3) begin /*normal trick*/
							case (datao_map_b[7:0])
								8'h14:begin tricked[4] <= 1'b1; end
								8'h81:begin tricked[3] <= 1'b1; end
								8'he5:begin tricked[2] <= 1'b1; end
								8'hd6:begin tricked[1] <= 1'b1; end
								8'h79:begin tricked[0] <= 1'b1; end
								default:begin end
							endcase
						end else if(datao_map_b[11:8] === 4'h0) begin/*normal trick*/
							case (datao_map_b[7:0])
								8'h14:begin tricked[4] <= 1'b1; end
								8'h81:begin tricked[3] <= 1'b1; end
								8'he5:begin tricked[2] <= 1'b1; end
								8'hd6:begin tricked[1] <= 1'b1; end
								8'h79:begin tricked[0] <= 1'b1; end
								default:begin end
							endcase
						end else begin
						end
					end else begin
					end
			end
	end
	
	always @ (posedge clk)begin
		if(!clrnn) begin /*re-initialization and show the cover*/
			x_block <= 4'h3;
			y_block <= 4'h2;
			wasReady<=1'b0;
			bounced<=1'b0;
		end else begin
			if (!PS2_was_ready && PS2_ready && !PS2_moved) begin /*the input is legal*/
				case (keys[8:0])
					9'h1c: begin x_block <= x_block - 1'd1;dir_rec <= 2'b00; bounced <= 1'b0;PS2_moved <= 1'b1;end//left
					9'h23: begin x_block <= x_block + 1'd1;dir_rec <= 2'b01; bounced <= 1'b0;PS2_moved <= 1'b1;end//right
					9'h1d: begin y_block <= y_block - 1'd1;dir_rec <= 2'b10; bounced <= 1'b0;PS2_moved <= 1'b1;end//down
					9'h1b: begin y_block <= y_block + 1'd1;dir_rec <= 2'b11; bounced <= 1'b0;PS2_moved <= 1'b1;end//up
					default: ;
				endcase
			end else if(!PS2_was_ready && PS2_ready && PS2_moved)begin
				PS2_moved <= 1'b0;//in order the up of the key makes a second moving
			end else if (is_wall && bounced === 1'b0) begin /*bounce on the wall*/
				case (dir_rec)
					2'b00:begin x_block <= x_block+1'd1; bounced <= 1'b1;end
					2'b01:begin x_block <= x_block-1'd1; bounced <= 1'b1;end
					2'b10:begin y_block <= y_block+1'd1; bounced <= 1'b1;end
					2'b11:begin y_block <= y_block-1'd1; bounced <= 1'b1;end
				default: ;
				endcase
			end
			PS2_was_ready <= PS2_ready;/*record*/
		end
	end
	
	
	always @ (posedge clk) begin
		if(!clrnn) begin /*re-initialization and show the cover*/
			show_data <= datao_start;
			pic_addr<=rad*10'd640+cad;
			heart_addr <= 11'b0;
			map_addr <= 9'b0;
		end else begin
		//calculate	
		pic_addr <= rad*10'd640+cad;
		heart_addr <= (rad + 5'd20 - y_pixel) * 6'd40 + cad + 5'd20 - x_pixel;
		map_addr <=(( rad / 6'd40 ) * 5'd16 + ( cad / 6'd40 ));
			if(finished === 2'b00) begin /*gaming*/
				if ((x_square + y_square < r_square)) begin /*in view*/
					if( (rad + 5'd20 >= y_pixel) && (cad + 5'd20 >= x_pixel) && (rad < 20 + y_pixel) && (cad < 20 + x_pixel)) begin /*is the player icon*/
						show_data <=datao_heart;
					end else if (is_wall_b) begin /*is wall*/
						show_data <= wall_color;
					end else if (datao_map === 16'h0003) begin /*is goal*/
						show_data <= 12'hfff;
					end else if (is_road_b) begin /*is road*/
						show_data <= 12'h000;
					end else if (datao_map === 16'h0002) begin /*is trap*/
						show_data <= 12'h002;
					end else begin
						show_data <= 12'h777; /*undefined block:should not appear*/
					end
				end else begin /*out view*/
					show_data <= datao_pic; 
				end
			end else if(finished === 2'b01) begin /*won*/
			end else if(finished === 2'b10) begin /*died*/
				show_data <= datao_died;
			end else if(finished === 2'b11) begin /*un-started*/
				//show_data <= datao_start;
			end else begin
				show_data <= 12'h555; /*umdefined status:should not appear*/
			end
		end
		reset <= clrnn;/*record*/
	end
				
				
endmodule
