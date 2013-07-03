
//
// Copyright (c) Deja vu Security
//
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
// copies of the Software, and to permit persons to whom the Software is 
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in   
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//
// Authors:
//   Michael Eddington (mike@dejavusecurity.com)
//

/*
 * This is a generic power glitcher that can be used for
 * glitching Vcc or ground.
 *
 * To operate, first set rst_i to high, then set run_i during each test
 * cycle. Repeat until finished_o is raised.
 */
module deja_glitch_power (
	// wishbone
	input	wire	clk_i,
	input	wire	rst_i,
	input	wire	stb_i,
	input	wire	we_i,
	input	wire	[3:0] adr_i,
	input	wire	[7:0] dat_i,
	
	output	reg		ack_o,
	output	reg		[7:0] dat_o,
	
	// power glitching
	input	wire	run_i,	// Test running (yes/no)
	output	reg		power_o
	);


// READ or WRITE Size of Glitch (default 1)
// `define DEJA_GLITCH_POWER_SIZE		4'd0
// READ or WRITE iteration step (default 1)
// `define DEJA_GLITCH_POWER_STEP		4'd1
// READ status flags
// `define DEJA_GLITCH_POWER_STATUS	4'd2
 
`define	STATE_IDLE		4'd0
`define	STATE_RUN		4'd1
`define	STATE_FINISHED	4'd2
`define STATE_RUN_IDLE	4'd3

reg		[63:0]	run_cnt;
reg		[63:0]	iter_cnt;	// Iteration count
reg		[3:0]	state;
reg		[7:0]	size;		// Size of glitch (count of clk_i)
reg		[7:0]	step;		// Step size (count of clk_i)
reg				finished;	// Test completed

`define SIZE_START_RUN_CNT	(iter_cnt * step)
`define SIZE_STOP_RUN_CNT	((iter_cnt * step) + size)

always @ (posedge clk_i)
begin

	// THERE BE MONSTERS HERE
	power_o		<= power_o;
	run_cnt		<= run_cnt;
	iter_cnt	<= iter_cnt;
	state		<= state;
	size		<= size;
	step		<= step;
	finished	<= finished;
	ack_o		<= 1'b0;
	dat_o		<= dat_o;

	// RESET STATE
	if(rst_i)
	begin
		size		<= 8'd1;
		step		<= 8'd1;
		finished	<= 1'b0;
	
		power_o		<= 1'b1;
		dat_o		<= 8'd0;
		ack_o		<= 1'b0;
		
		run_cnt		<= 64'd0;
		iter_cnt	<= 64'd0;
		state		<= `STATE_IDLE;
	end
	else
	begin
	
		// WISHBONE ------------------------
	
		// wishbone write operations
		if(stb_i && we_i)
		begin
			case(adr_i)
				`DEJA_GLITCH_POWER_SIZE:
				begin
					size <= dat_i;
					ack_o <= 1'b1;
				end
				`DEJA_GLITCH_POWER_STEP:
				begin
					step <= dat_i;
					ack_o <= 1'b1;
				end
				
				// unknown address handler
				default:
				begin
					dat_o <= 8'd0;
					ack_o <= 1'b0;
				end
			endcase
		end
		// wishbone read operations
		else if(stb_i && !we_i)
		begin
			case(adr_i)
				`DEJA_GLITCH_POWER_SIZE:
				begin
					dat_o <= size;
					ack_o <= 1'b1;
				end
				`DEJA_GLITCH_POWER_STEP:
				begin
					dat_o <= step;
					ack_o <= 1'b1;
				end
				`DEJA_GLITCH_POWER_STATUS:
				begin
					dat_o <= {7'd0, finished};
					ack_o <= 1'b1;
				end
				
				// unknown address handler
				default:
				begin
					dat_o <= 8'd0;
					ack_o <= 1'b0;
				end
			endcase
		end
		
		// GLITCHING!!! -------------------
		
		case(state)
			`STATE_IDLE:
			begin
				power_o <= 1'b1;
				finished <= 1'b0;
				
				if(run_i)
				begin
					// When iter_cnt == 0, we glitch on run_cnt == 0
					if(`SIZE_START_RUN_CNT == 0)
					begin
						power_o <= 1'b0;
					end
					
					run_cnt <= 64'd1; // this is count 0, next cycle will be 1.
					state <= `STATE_RUN;
				end
			end
			
			`STATE_RUN:
			begin
				run_cnt <= (run_cnt + 64'd1);

				if(!run_i)
				begin
					state <= `STATE_FINISHED;
				end
				else if(run_cnt == `SIZE_START_RUN_CNT)
				begin
					power_o <= 1'b0;
				end
				else if(run_cnt == `SIZE_STOP_RUN_CNT)
				begin
					power_o <= 1'b1;
					state <= `STATE_RUN_IDLE;
				end
			end
			
			`STATE_RUN_IDLE:
			begin
				if(!run_i)
				begin
					iter_cnt <= iter_cnt + 64'd1;
					state <= `STATE_IDLE;
				end
			end
			
			`STATE_FINISHED:
			begin
				iter_cnt <= iter_cnt + 64'd1;
				power_o <= 1'b1;
				finished <= 1'b1;
				state <= `STATE_IDLE;
			end
		endcase
	end
end

endmodule

// END
