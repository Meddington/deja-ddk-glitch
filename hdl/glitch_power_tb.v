`timescale 1 ns/1 ps

module glitch_power_tb();

reg		tb_clk_o;
reg		tb_rst_o;
reg		tb_run_o;
reg		[8:0]tb_size_o;
reg		[8:0]tb_step_o;

reg		tb_stb_o;
reg		tb_we_o;
reg		[3:0] tb_adr_o;
reg		[7:0] tb_dat_o;
wire	tb_ack_i;
wire	[7:0] tb_dat_i;

wire	tb_finished_i;
wire	tb_power_i;

deja_glitch_power dgp (

	.clk_i(tb_clk_o),	// Clock in
	.rst_i(tb_rst_o),	// Reset test
	.stb_i(tb_stb_o),
	.adr_i(tb_adr_o),
	.dat_i(tb_dat_o),
	.ack_o(tb_ack_i),
	.dat_o(tb_dat_i),
	
	.run_i(tb_run_o),	// Test running (yes/no)
	.power_o(tb_power_i));

initial
begin
			tb_clk_o	<= 1'b0;
			tb_rst_o	<= 1'b0;
			tb_run_o	<= 1'b0;
			tb_size_o	<= 8'd1;
			tb_step_o	<= 8'd1;
end

always
begin
	#1		tb_clk_o <= ~tb_clk_o;
end

always
begin

	#1		tb_rst_o = 1'b1; 
	#4		tb_rst_o = 1'b0;
	
	#2		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	// --------------------------

	#2		tb_size_o = 8'd3;
			tb_step_o = 8'd2;
	
			tb_rst_o = 1'b1;
	#4		tb_rst_o = 1'b0;
	
	#2		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

	#10		tb_run_o = 1'b1;
	#100	tb_run_o = 1'b0;

end

endmodule

// end
