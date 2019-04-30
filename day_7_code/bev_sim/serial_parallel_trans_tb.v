// =============================================================================
// Filename: serial_parallel_trans_tb.v
// Author: KANG, Jian
// Email: jkangac@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
//Description:
// -----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

module serial_parallel_trans_tb;

// ----------------------------------
// Local parameter declaration
// ----------------------------------
localparam CLK_PERIOD = 5;  // clock period: ns
localparam N = 4;// width of test data
// ----------------------------------
// Interface of the tested module
// ----------------------------------
reg clk;
reg [N-1:0] data_in;
wire [N-1:0] data_out;
reg data_enable;
wire data_valid;
wire data_last;
reg rst;
reg [1:0] mode;

// ----------------------------------
// Instantiate the tested module
// ----------------------------------
serial_parallel_trans 
	#(
		.N(N)//default width is 3 bit
	)
serial_parallel_trans_inst
	(
		.clk(clk),
		.rst(rst),
		.data_in(data_in),
		.mode(mode),
		.data_enable(data_enable),//show the master is ready
		.data_out(data_out),
		.data_valid(data_valid), //show the module is free
		.data_last(data_last)
	);

// ----------------------------------
// Clock generation
// ----------------------------------
initial begin
  clk = 1'b0;
  forever #(CLK_PERIOD/2.0) clk = ~clk;
end

// ----------------------------------
// Input stimulus
// Generate the ad-hoc stimulus
//This is an example
//initial begin
  // Reset
  //rst         = 1'b1;
  //start       = 1'b0;
  //dividend    = 32'd0;
  //divisor     = 32'd0;
  //#(2*CLK_PERIOD) rst = 1'b0;
  //end
// ----------------------------------

initial
	begin
	//Add Your Code
		rst = 1'b1;
		#22 
		rst = 1'b0;
	end

initial begin
//the first case: test P/S transform
		#35
		mode <= 2'd1;
		data_enable <= 1'b1;
		data_in <= 4'd11;
		#(2*CLK_PERIOD)
		wait(data_last);
		$finish;
end
// ----------------------------------
// Output monitor
//This is an example
//always @(posedge clk) begin
  //if (done) begin
    //("%0d / %0d: quotient = %0d, remainder = //%0d", dividend, divisor,
      //quotient, remainder);
  //end
// ----------------------------------
//Add Your Code

endmodule