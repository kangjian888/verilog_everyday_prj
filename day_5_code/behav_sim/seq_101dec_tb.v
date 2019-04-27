// =============================================================================
// Filename: seq_101dec_tb.v
// Author: KANG, Jian
// Email: jkangac@connect.ust.hk
// Affiliation: Hong Kong University of Science and Technology
//Description:
// -----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

module seq_101dec_tb;

// ----------------------------------
// Local parameter declaration
// ----------------------------------
localparam CLK_PERIOD = 5;  // clock period: ns

// ----------------------------------
// Interface of the tested module
// ----------------------------------
reg clk;
reg rst;
reg sin;
wire det;

// ----------------------------------
// Instantiate the tested module
// ----------------------------------
seq_101det seq_101det_inst(
	.clk(clk),
	.rst(rst),
	.data_in(sin),
	.flag_101(det)
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
initial begin
	rst = 1'b1;
	#22 rst = 1'b0;
end

initial begin
	repeat(100)begin
		@(negedge clk)
			sin = {$random};
		end
	$finish;
end

initial begin
	$dumpfile("seq_101dec_tb.vdc");
	$dumpvars();
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
